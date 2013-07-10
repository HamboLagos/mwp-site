FactoryGirl.define do
  factory :athlete do
    first_name "Danny"
    last_name "Trejo"
    sequence(:email) { |n| "example_#{n}@CPMensWaterPolo.com" }
    password "foobar"
    password_confirmation "foobar"
  end
end
