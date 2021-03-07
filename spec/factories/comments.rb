FactoryBot.define do
  factory :comment do
    comment { "very good!!" }
    rate { 4 }
    association :user
    association :product
  end
end
