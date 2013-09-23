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
      tournament.travel_rosters.each do |tr|
        page.should have_selector('li#tournament_show_name', text: tr.name)
        page.should have_selector('li#tournament_show_phone', text: tr.athlete.phone_number)
        page.should have_selector('li#tournament_show_car',
                                  text: tr.driver? ? "driver" : "passenger of #{tr.car_name}")
      end
    end
  end

  RSpec::Matchers.define :show_tournaments_page do |tournaments|
    match do |page|
      page.should have_selector('h1', text: "Tournaments")
      tournaments.each do |tournament|
        page.should have_link(tournament.location, href: tournament_path(tournament))
        # page.should have_selector('li#tournament_index_start_date',
        #                           text: tournament.start_date.strftime("%Y-%m-%d"))
        # page.should have_selector('li#tournament_index_end_date',
        #                           text: tournament.end_date.strftime("%Y-%m-%d"))
        page.should have_link('Create New Tournament', href: new_tournament_path)
      end
    end
  end

  def valid_create_tournament(tournament_data)
    visit new_tournament_path

    #Tournament metadata
    find(:xpath, "//input[@id='tournament_season_id']").set "#{tournament_data.season.id}"
    fill_in 'Location', with: "Cal Poly"
    select tournament_data.start_date.year, from: 'tournament_start_date_1i'
    select Date::MONTHNAMES[tournament_data.start_date.month], from: 'tournament_start_date_2i'
    select tournament_data.start_date.day, from: 'tournament_start_date_3i'
    select tournament_data.end_date.year, from: 'tournament_end_date_1i'
    select Date::MONTHNAMES[tournament_data.end_date.month], from: 'tournament_end_date_2i'
    select tournament_data.end_date.day, from: 'tournament_end_date_3i'
    click_button 'Submit'

    #Tournament Athletes
    tournament_data.athletes.each do |athlete|
      check athlete.name
    end
    click_button 'Continue'

    #Tournament Drivers
    check tournament_data.athletes.first.name
    click_button 'Continue'

    #Passengers
    click_button 'Continue'
  end

  def invalid_create_tournament
    visit new_tournament_path
    click_button 'Submit'
  end
end

