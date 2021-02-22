FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "sample-#{n} product" }
    price { 10000 }
    description { "Sample Product's description" }
    product_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png')) }
    stock_quantity { 10 }
  end
end
