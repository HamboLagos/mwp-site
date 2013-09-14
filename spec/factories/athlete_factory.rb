FactoryGirl.define do
  factory :athlete do
    first_name "Danny"
    last_name "Trejo"
    sequence(:email) { |n| "example_#{n}@cpmenswaterpolo.com" }
    year_in_school "First"
    phone_number "(987) 654-3210"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :admin, parent: :athlete do
    admin "true"
  end
end
