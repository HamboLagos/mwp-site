module TournamentPagesUtilities

  RSpec::Matchers.define :show_new_tournament_page do
    match do |page|
      page.should have_selector('h1', text: "Create a New Tournament")
      page.should show_edit_tournament_form
    end
  end

  RSpec::Matchers.define :show_edit_tournament_form do
    match do |page|
      page.should have_selector("input[name='tournament[season_id]']")
      page.should have_selector("input[name='tournament[location]']")
      page.should have_selector("select[name='tournament[start_date(1i)]']")
      page.should have_selector("select[name='tournament[start_date(2i)]']")
      page.should have_selector("select[name='tournament[start_date(3i)]']")
      page.should have_selector("select[name='tournament[end_date(1i)]']")
      page.should have_selector("select[name='tournament[end_date(2i)]']")
      page.should have_selector("select[name='tournament[end_date(3i)]']")
    end
  end

  RSpec::Matchers.define :show_tournament_page do |tournament|
    match do |page|
      page.should have_selector('h1',
                                text: "#{tournament.season.year} #{tournament.location} Tournament")
      page.should have_selector('h3', text: "#{tournament.start_date.strftime("%A, %B %-d %Y")}")
      page.should have_selector('h3', text: "#{tournament.end_date.strftime("%A, %B %-d %Y")}")
      #TODO check for athletes, including drivers and passengers
      #TODO check for start and end dates
    end
  end

  def valid_create_tournament(tournament_data)
    visit new_tournament_path

    find(:xpath, "//input[@id='tournament_season_id']").set "#{tournament_data.season.id}"
    # choose tournament_data.season.year_as_string
    fill_in 'Location', with: "Cal Poly"
    select tournament_data.start_date.year, from: 'tournament_start_date_1i'
    select Date::MONTHNAMES[tournament_data.start_date.month], from: 'tournament_start_date_2i'
    select tournament_data.start_date.day, from: 'tournament_start_date_3i'
    select tournament_data.end_date.year, from: 'tournament_end_date_1i'
    select Date::MONTHNAMES[tournament_data.end_date.month], from: 'tournament_end_date_2i'
    select tournament_data.end_date.day, from: 'tournament_end_date_3i'

    tournament_data.athletes.each do |athlete|
      check athlete.name
    end

    click_button 'Submit'
  end

  def invalid_create_tournament
    visit new_tournament_path
    click_button 'Submit'
  end
end

