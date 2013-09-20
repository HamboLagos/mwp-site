FactoryGirl.define do
  trait :season_traits do
    sequence(:year, 2000) { |n| n }
    current true
  end

  factory :season do
    season_traits
  end
end
