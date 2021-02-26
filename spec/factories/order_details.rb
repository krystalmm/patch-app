FactoryBot.define do
  factory :order_detail do
    product { nil }
    order { nil }
    quantity { 1 }
  end
end
