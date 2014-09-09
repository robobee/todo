FactoryGirl.define do
  factory :project do
    title     "Bake A Cake"
  end

  factory :task	do
    name "Buy ingredients"
    priority 1
    deadline Date.new(2014, 10, 10)
    status "New"
    project
  end
  
end