namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    seasons = make_seasons
    athletes = make_athletes(seasons)
    make_posts(athletes[0..4])
    make_tournaments(athletes)
  end
end

def make_seasons
  seasons = []

  2.times do |n|
    year = 2012+n
    seasons << Season.create!(year: year)
  end

  seasons
end

def make_athletes(seasons)
  athletes = []

  10.times do |n|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = "example-#{n+1}@cpmwp.org"
    year = "First"
    phone = "(987) 654-3210"
    password = "foobar"
    athletes << Athlete.create!(first_name:             first_name,
                                last_name:              last_name,
                                email:                  email,
                                year_in_school:         year,
                                phone_number:           phone,
                                seasons:                seasons,
                                password:               password,
                                password_confirmation:  password)
  end

  # make admin, president, etc. eventually for development
  athletes << Athlete.create!(first_name:           'Hamilton',
                              last_name:             'Little',
                              email:                 'hamilton.little@gmail.com',
                              year_in_school:        'Fifth+',
                              phone_number:          '(650) 793-3251',
                              seasons:               seasons,
                              password:              'foobar',
                              password_confirmation: 'foobar',
                              admin: true)

  athletes
end

def make_posts(athletes)
  3.times do
    title = Faker::Lorem.sentence(3)
    content = Faker::Lorem.paragraph(2)
    athletes.each do |athlete|
      athlete.posts.create!(title: title, content: content)
    end
  end
end

def make_tournaments(athletes)
  locations = ["Cal Poly, SLO", "UC San Diego", "UC Los Angeles", "UC Santa Barbara"]
  current_season = Season.current_season
  last_season = Season.find_by(year: current_season.year-1)
  4.times do |n|
    start_date = Date.today + 7*n - 1.year
    end_date = Date.today + 7*n + 2 - 1.year
    tourney = Tournament.create!(location: locations[n],
                      season: last_season,
                      start_date: start_date,
                      end_date: end_date,
                      athletes: athletes[rand(1..5)..rand(6..11)])
    tourney.travel_rosters.each do |tr|
      if tr.id < 3
        tr.update!(driver: true)
      elsif tr.id < (Athlete.all.count-2)/2
        tr.update(driver: TravelRoster.find(1).athlete_id)
      else
        tr.update(driver: TravelRoster.find(2).athlete_id)
      end
    end
  end

  4.times do |n|
    start_date = Date.today + 7*n 
    end_date = Date.today + 7*n + 2
    tourney = Tournament.create!(location: locations[n],
                      season: current_season,
                      start_date: start_date,
                      end_date: end_date,
                      athletes: athletes[rand(1..5)..rand(6..11)])
    tourney.travel_rosters.each do |tr|
      if tr.id < 3
        tr.update!(driver: true)
      elsif tr.id < (Athlete.all.count-2)/2
        tr.update(driver: TravelRoster.find(1).athlete_id)
      else
        tr.update(driver: TravelRoster.find(2).athlete_id)
      end
    end
  end
end
