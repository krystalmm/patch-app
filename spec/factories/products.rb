FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "sample-#{n} product" }
    price { 10_000 }
    description { "Sample Product's description" }
    product_image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.png')) }
    stock_quantity { 10 }

    trait :stock_1 do
      stock_quantity { 1 }
    end

    trait :stock_0 do
      stock_quantity { 0 }
    end
  end
end
