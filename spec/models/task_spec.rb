require 'spec_helper'

describe Task do

  let(:project) { FactoryGirl.create(:project) }
  before { @task = project.tasks.build(name: "Lorem ipsum", status: "New", priority: 1, deadline: Date.new(2014, 10, 10)) }

  subject { @task }

  it { should respond_to(:name) }
  it { should respond_to(:project_id) }
  it { should respond_to(:status) }
  it { should respond_to(:priority) }
  it { should respond_to(:deadline) }
  it { should respond_to(:project)}
  its(:project) { should eq project }

  it { should be_valid }

  describe "when project_id is not present" do
    before { @task.project_id = nil }
    it { should_not be_valid }
  end

  describe "with blank name" do
    before { @task.name = " " }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @task.name = "a" * 201 }
    it { should_not be_valid }
  end

  describe "with status not from: ( New, Done )" do
    before { @task.status = "foobar" }
    it { should_not be_valid }
  end

  describe "with missed deadline" do
    before { @task.deadline = Date.new(1999, 10, 10) }
    it { should_not be_valid }
  end

end