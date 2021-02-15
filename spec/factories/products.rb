FactoryBot.define do
  factory :product do
    name { "Sample item" }
    price { 10000 }
    description { "Sample item description" }
    stock_quantity { 100 }
  end
end

