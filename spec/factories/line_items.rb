FactoryBot.define do
  factory :line_item do
    sequence(:product_id) { |n| n }
    sequence(:cart_id) { |n| n }
    quantity { 1 }
    association :product
    association :cart
  end
end
