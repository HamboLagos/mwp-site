FactoryGirl.define do
  factory :season do
    sequence(:year, 2000) { |n| n }
    current true
  end
end
