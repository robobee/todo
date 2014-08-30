namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Project.create!(title: "Garage")
    Project.create!(title: "Work")
    Project.create!(title: "Fly To The Moon")
    Project.create!(title: "Become The President Of The Universe")
    Project.create!(title: "Bake A Cake")
    Project.create!(title: "Trip To Barselona")
    Project.create!(title: "A Lonely Project")

    projects = Project.all
    projects.each do |project|
      5.times do
        name = Faker::Lorem.sentence(5)
        project.tasks.create!(name: name, status: "New", priority: 1, deadline: 10.days.from_now)
      end
    end

  end
end