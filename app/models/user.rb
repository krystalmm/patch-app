require 'nkf'

class User < ApplicationRecord
  attr_accessor :remember_token, :reset_token
  before_save :downcase_email

  validates :name, presence: true, length: { maximum: 30 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false }
  validates :email, email_format: { with: VALID_EMAIL_REGEX, message: '正しいメールアドレスを入力してください。' }, allow_blank: true

  has_secure_password

  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

  VALID_POSTCODE_REGEX = /\A[0-9]{3}[0-9]{4}\z/.freeze
  validates :postcode, format: { with: VALID_POSTCODE_REGEX }, allow_blank: true

  VALID_KANA_REGEX = /\A[\p{katakana}\u{30fc}\s 　]+\z/.freeze
  validates :name_kana, presence: true, format: { with: VALID_KANA_REGEX }
  before_validation do
    self.name_kana = NKF.nkf('-W -w -Z1 --katakana', name_kana) if name_kana
  end

  # 都道府県番号と都道府県名の設定
  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end


  private

    # メールアドレスを全て小文字にする
    def downcase_email
      self.email = email.downcase
    end
end
