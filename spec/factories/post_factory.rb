FactoryGirl.define do
  factory :post do
    title "Example Title"
    content "Lorem ipsum dolor sit amet"
    association :author, factory: :athlete
  end
end
