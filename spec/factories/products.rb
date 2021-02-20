FactoryBot.define do
  factory :product do
    name { "Sample Product" }
    price { 10000 }
    description { "Sample Product's description" }
    product_image { "sample_product_image.png" }
    stock_quantity { 1 }
  end
end
