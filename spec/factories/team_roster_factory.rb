FactoryGirl.define do
  factory :team_roster do
    association :athlete
    association :season
  end
end
