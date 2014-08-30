FactoryGirl.define do
  factory :project do
    title     "Bake A Cake"
  end

  factory :task	do
    name "Buy ingredients"
    priority nil
    deadline Date.new(2014, 10, 10)
    status "New"
    project
  end
end