FactoryGirl.define do
  factory :post do
    title  Faker::Lorem.sentence(3)
    content  Faker::Lorem.paragraph(2)
    association :athlete
  end
end
