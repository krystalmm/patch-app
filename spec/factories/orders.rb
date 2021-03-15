FactoryBot.define do
  factory :order do
    quantity { 1 }
    status { 0 }
    price { 10000 }
    association :user
    association :card
    association :product
  end
end
