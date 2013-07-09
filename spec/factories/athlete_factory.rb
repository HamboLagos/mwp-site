FactoryGirl.define do
  factory :athlete do
    first_name "Joe"
    last_name "Blow"
    sequence(:email) { |n| "example_#{n}@CPMensWaterPolo.com" }
    password "foobar"
    password_confirmation "foobar"
  end
end
