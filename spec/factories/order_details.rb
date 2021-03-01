FactoryBot.define do
  factory :order_detail do
    quantity { 1 }
    association :order
    association :product
  end
end
