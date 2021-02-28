FactoryBot.define do
  factory :order_detail do
    sequence(:product_id) { |n| n }
    sequence(:order_id) { |n| n }
    quantity { 1 }
  end
end
