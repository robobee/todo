namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Project.create!(title: "Example User")
    Project.create!(title: "Garage")
    Project.create!(title: "Work")
    Project.create!(title: "Fly To The Moon")
    Project.create!(title: "Become The President Of The Universe")
    Project.create!(title: "Bake A Cake")
    Project.create!(title: "Trip To Barselona")
    Project.create!(title: "A Lonely Project")
  end
end