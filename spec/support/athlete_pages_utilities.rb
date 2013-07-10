module AthletePagesUtilities

  RSpec::Matchers.define :show_signup_page do
    match do |page|
      page.should have_selector('h1', text: 'Join the Team Roster')
      page.should have_selector("input[name='athlete[first_name]']")
      page.should have_selector("input[name='athlete[last_name]']")
      page.should have_selector("input[name='athlete[email]']")
      page.should have_selector("input[name='athlete[password]']")
      page.should have_selector("input[name='athlete[password_confirmation]']")
      page.should have_selector("input[value='Join']")
    end
  end

  RSpec::Matchers.define :show_roster_page do
    match do |page|
      page.should have_selector('h1', text:"#{Time.now.year} Roster")
    end
  end


  def valid_sign_up(athlete)
    fill_in 'athlete_first_name',            with: athlete.first_name
    fill_in 'athlete_last_name',             with: athlete.last_name
    fill_in 'athlete_email',                 with: athlete.email
    fill_in 'athlete_password',              with: athlete.password
    fill_in 'athlete_password_confirmation', with: athlete.password

    click_button "Join"
  end

  def invalid_sign_up
    click_button "Join"
  end

end
