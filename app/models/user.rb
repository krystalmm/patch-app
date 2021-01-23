class User < ApplicationRecord
  # データベースに保存される前に全ての文字列を小文字に変換する！（大文字と小文字を区別しないため！）
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freez
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end
