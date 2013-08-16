module AthletePagesUtilities

  RSpec::Matchers.define :show_signup_page do
    match do |page|
      page.should have_selector('h1', text: 'Join the Team Roster')
      page.should show_athlete_form
    end
  end

  RSpec::Matchers.define :show_edit_athlete_page do
    match do |page|
      page.should have_selector('h1', text: 'Edit Your Profile')
      page.should show_athlete_form
    end
  end

  Rspec::Matchers.define :show_athlete_form do |athlete|
    match do |page|
      page.should have_selector("input[name='athlete[first_name]']",
                                text: athlete.nil? ? "" : athlete.first_name)
      page.should have_selector("input[name='athlete[last_name]']",
                                text: athlete.nil? ? "" : athlete.last_name)
      page.should have_selector("input[name='athlete[email]']",
                                text: athlete.nil? ? "" : athlete.email)
      page.should have_selector("input[name='athlete[year_in_school]']")
      page.should have_selector("input[name='athlete[password]']")
      page.should have_selector("input[name='athlete[password_confirmation]']")
      page.should have_selector("input[value='Submit']")
    end
  end

  RSpec::Matchers.define :show_roster_page do
    match do |page|
      page.should have_selector('h1', text:"#{Time.now.year} Roster")
    end
  end

  def valid_sign_up(athlete)
    visit signup_path
    fill_in 'athlete_first_name',            with: athlete.first_name
    fill_in 'athlete_last_name',             with: athlete.last_name
    fill_in 'athlete_email',                 with: athlete.email
    choose 'First'
    fill_in 'athlete_phone_number',          with: athlete.phone_number
    fill_in 'athlete_password',              with: athlete.password
    fill_in 'athlete_password_confirmation', with: athlete.password

    click_button "Submit"
  end

  def invalid_sign_up
    visit signup_path
    click_button "Submit"
  end

  def invalid_edit
    fill_in "athlete_first_name", with: " " #missing first name invalidates athlete
    click_button "Submit"
  end

  def edit_athlete_info different_info
    fill_in "athlete_first_name",             with: different_info.first_name
    fill_in "athlete_last_name",              with: different_info.last_name
    fill_in "athlete_email",                  with: different_info.email
    choose different_info.year_in_school
    fill_in "athlete_phone_number",           with: athlete.phone_number
    fill_in "athlete_password",               with: different_info.password
    fill_in "athlete_password_confirmation",  with: different_info.password_confirmation

    click_button "Submit"
  end

end
