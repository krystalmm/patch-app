class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :comment, presence: true, length: { maximum: 800 }
end
