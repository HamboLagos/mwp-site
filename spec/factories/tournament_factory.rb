FactoryGirl.define do
  trait :tournament_traits do
    location "Cal Poly, SLO"
    sequence(:start_date) { |n| Date.today + n }
    sequence(:end_date) { |n| Date.today + n+1 }
  end

  factory :tournament do
    tournament_traits

    before(:create) do |tournament, evaluator|
      season = FactoryGirl.create(:season)
      tournament.season = season
      season.tournaments << tournament
    end
  end

  factory :tournament_no_associations, class: Tournament do
    tournament_traits
  end
end
