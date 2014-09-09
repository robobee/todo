require 'spec_helper'

describe "TaskPages" do

  subject { page }
  let(:task) { FactoryGirl.create(:task) }
  let(:project) { FactoryGirl.create(:project) }

  describe "Edit Task page" do
  	before { visit edit_task_path(task) }

  	it { should have_content('Edit Task') }
    it { should have_content('Buy ingredients') }
    it { should have_content('Save changes') }
    it { should have_title("TODO App | Edit Task") }

  end

  describe "New Task" do
  	before { visit root_path }

  	it { should have_content('Bake A Cake') }
  end

end
