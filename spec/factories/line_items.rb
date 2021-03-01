FactoryBot.define do
  factory :line_item do
    quantity { 1 }
    association :product
    association :cart
  end
end
