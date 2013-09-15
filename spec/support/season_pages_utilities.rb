module SeasonPagesUtilities

  RSpec::Matchers.define :show_new_season_page do
    match do |page|
      page.should have_selector('h1', text: "Create a New Season")
      page.should show_edit_season_form
    end
  end

  RSpec::Matchers.define :show_edit_season_form do
    match do |page|
      page.should have_selector("input[name='season[year]']")
    end
  end

  def valid_create_new_season
    visit new_season_path
    fill_in 'Year', with: "2013"
    click_button 'Submit'
  end
end
