FactoryGirl.define do
  factory :athlete do
    first "Joe"
    last "Blow"
    email "example@CPMensWaterPolo.com"
    year 1
    password "foobar"
    password_confirmation "foobar"
  end
end
