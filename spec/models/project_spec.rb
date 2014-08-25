require 'spec_helper'

describe Project do
  
	before { @project = Project.new(title: "Make TODO App for RubyGarage")}
	subject { @project }

	it { should respond_to(:title)}
	it { should be_valid }	

  describe "when title is not present" do
    before { @project.title = " " }
    
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

end