require 'spec_helper'

describe "ProjectPages" do

  subject { page }

  describe "Index page" do
  	before { visit root_path }

    it { should have_content('SIMPLE TODO LISTS') }
    it { should have_content('Add TODO List') }
    it { should have_title("TODO App | Projects") }

  end

  describe "New project page" do
  	before { visit new_project_path }

    it { should have_content('Create new Project') }
    it { should have_title("TODO App | New Project") }

  end

  describe "Edit project page" do
  	let(:project) { FactoryGirl.create(:project) }
  	before { visit edit_project_path(project) }

    it { should have_content('Edit Project') }
    it { should have_title("TODO App | Edit Project") }

  end

end
