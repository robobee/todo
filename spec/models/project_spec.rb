require 'spec_helper'

describe Project do
  
	before { @project = Project.new(title: "Make TODO App for RubyGarage")}
	subject { @project }

	it { should respond_to(:title) }
  it { should respond_to(:tasks) }
	it { should be_valid }

  describe "when title is not present" do
    before { @project.title = " " }
    
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @project.title = "a" * 201 }
    it { should_not be_valid }
  end

  describe "when project title already taken" do
    before do
      project = @project.dup
      project.title = @project.title.upcase
      project.save
    end

    it { should_not be_valid }
  end

  describe "task associations" do

    before { @project.save }
    let!(:older_task) do
      FactoryGirl.create(:task, project: @project)
    end
    let!(:newer_task) do
      FactoryGirl.create(:task, project: @project)
    end

    it "should have the right tasks in the right order" do
      expect(@project.tasks.to_a).to eq [older_task, newer_task]
    end

    it "should destroy associated tasks" do
      tasks = @project.tasks.to_a
      @project.destroy
      expect(tasks).not_to be_empty
      tasks.each do |task|
        expect(Task.where(id: task.id)).to be_empty
      end
    end

  end

end