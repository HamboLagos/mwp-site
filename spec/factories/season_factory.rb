FactoryGirl.define do
  factory :season do
    sequence(:year) { |n| n+2000 }
  end
end
