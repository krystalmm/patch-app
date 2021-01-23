class User < ApplicationRecord
  # データベースに保存される前に全ての文字列を小文字に変換する！（大文字と小文字を区別しないため！）
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }
  VALID_POSTCODE_REGEX = /\A[0-9]{3}-[0-9]{4}\z/.freeze
  validates :postcode, format: { with: VALID_POSTCODE_REGEX }, allow_blank: true
  VALID_KANA_REGEX = /\A[\p{katakana}\u{30fc}]+\z/.freeze
  validates :name_kana, presence: true, format: { with: VALID_KANA_REGEX }
end

