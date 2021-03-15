FactoryBot.define do
  factory :comment do
    comment { "very good!!" }
    association :user
    association :product
  end
end
