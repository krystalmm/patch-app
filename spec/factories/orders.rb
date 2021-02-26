FactoryBot.define do
  factory :order do
    user { nil }
    card { nil }
    product { nil }
    quantity { 1 }
    status { 1 }
    postage { 1 }
    price { 1 }
  end
end
