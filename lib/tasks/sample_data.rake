namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Project.create!(title: "Fly To The Moon")
    Project.create!(title: "Bake A Cake")
    Project.create!(title: "Plan Trip To Barselona")
    
    projects = Project.all
    projects.each do |project|
      5.times do
        name = Faker::Lorem.sentence(5)
        project.tasks.create!(name: name, status: "New")
      end
    end

  end
end