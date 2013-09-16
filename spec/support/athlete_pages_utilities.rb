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
      page.should have_selector("input[name='athlete[season_ids][]']")
      page.should have_selector("input[value='Submit']")
    end
  end

  # the contents of the roster page change depending if the user is signed in
  # page.should show_roster_page({ signed_in: true }, ath1, ath2, ath3)
  #
  # NOTE: options hash must be passed literally as first argument
  #       ok to leave options hash out (defaults to not signed in view)
  #       any number of athletes can be passed in, including none
  # the following are all valid:
  # page.should show_roster_page({ signed_in: false }, ath1, ath2, ath3)
  # page.should show_roster_page(ath1, ath2, ath3)
  # page.should show_roster_page()
  RSpec::Matchers.define :show_roster_page do |options = {}, *athletes|
  match do |page|
    page.should have_selector('h1', text: "Roster")

    is_signed_in = options[:signed_in] || false
    athletes.each do |athlete|
      page.should have_selector('li', text: athlete.name)
      page.should have_selector('li', text: athlete.year_in_school)

      if is_signed_in
        page.should have_selector('li', text: athlete.email)
        page.should have_selector('li', text: athlete.phone_number)
      end
    end
  end
  end

  RSpec::Matchers.define :show_change_password_page do
    match do |page|
      page.should have_selector('h1', text: 'Change Your Password')
      page.should have_selector("input[name='old_password']")
      page.should have_selector("input[name='old_password_confirmation']")
      page.should have_selector("input[name='password']")
      page.should have_selector("input[name='password_confirmation']")
      page.should have_selector("input[value='Change Password']")
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
    athlete.seasons.each do |season|
      check season.year.to_s
    end

    click_button "Submit"
  end

  def invalid_sign_up
    visit signup_path
    click_button "Submit"
  end

  def invalid_edit_no_name athlete
    fill_in "athlete_password", with: athlete.password
    fill_in "athlete_password_confirmation", with: athlete.password
    fill_in "athlete_first_name", with: " " #missing first name invalidates athlete
    click_button "Submit"
  end

  def invalid_edit_no_password
    fill_in "athlete_password", with: ' ' #password will not match records, invalidating change
    fill_in "athlete_password_confirmation", with: ' '
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

  def invalid_password_change
    click_button "Change Password"
  end

  def valid_password_change athlete
    fill_in 'old_password',              with: athlete.password
    fill_in 'old_password_confirmation', with: athlete.password
    fill_in 'password',                  with: athlete.password.reverse
    fill_in 'password_confirmation',     with: athlete.password.reverse

    click_button "Change Password"
  end
end
