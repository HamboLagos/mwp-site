module AthletePagesUtilities

  RSpec::Matchers.define :show_new_athlete_page do
    match do |page|
      page.should have_selector('h1', text: 'Join the Team Roster')
      page.should have_selector('submit', text: 'Join')
    end
  end

end
