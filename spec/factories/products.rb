FactoryBot.define do
  factory :product do
    name { "MyString" }
    price { 1 }
    description { "MyText" }
    product_image { "MyString" }
    stock_quantity { 1 }
  end
end
