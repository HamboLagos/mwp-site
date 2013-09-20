FactoryGirl.define do
  trait :athlete_traits do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    sequence(:email) { |n| "example_#{n}@cpmenswaterpolo.com" }
    year_in_school "First"
    phone_number "(987) 654-3210"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :athlete do
    athlete_traits

    before(:create) do |athlete, evaluator|
      season = FactoryGirl.create(:season)
      athlete.seasons << season
      season.athletes << athlete
    end

    after(:create) do |athlete, evaluator|
      current_season = athlete.seasons.find do |season|
        season.current?
      end
      tournament = FactoryGirl.build(:tournament_no_associations)
      tournament.season = current_season
      tournament.save
      tournament.athletes << athlete
      athlete.tournaments << tournament
    end
  end

  factory :admin, parent: :athlete do
    admin "true"
  end

  factory :athlete_no_associations, class: Athlete do
    athlete_traits
  end
end
