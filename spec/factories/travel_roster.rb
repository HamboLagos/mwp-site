FactoryGirl.define do
  factory :travel_roster do
    association :athlete
    association :tournament
  end
end
