namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_athletes
    make_posts
  end
end

def make_athletes
  99.times do |n|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = "example-#{n+1}@cpmwp.org"
    Athlete.create!(first:  first_name,
                    last:   last_name,
                    email:  email,
                    year:   1)
  end
end

def make_posts
  athletes = Athlete.all(limit: 5)
  3.times do
    title = Faker::Lorem.sentence(3)
    content = Faker::Lorem.paragraph(5)
    athletes.each do |athlete|
      athlete.posts.create!(title: title, content: content)
    end

  end
end
