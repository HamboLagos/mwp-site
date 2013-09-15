FactoryGirl.define do
  factory :tournament do
    association :season
    sequence(:start_date) { |n| Date.today + n }
    sequence(:end_date) { |n| Date.today + n+1 }
  end
end
