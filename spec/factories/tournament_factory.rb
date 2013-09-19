FactoryGirl.define do
  factory :tournament do
    association :season
    location "Cal Poly, SLO"
    sequence(:start_date) { |n| Date.today + n }
    sequence(:end_date) { |n| Date.today + n+1 }
  end
end
