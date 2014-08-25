class ProjectsController < ApplicationController

def index
  @projects = Project.all
end

def show
#  id = 	params[:id]
#  @project = Project.find(id)	
end

def new
#  @project = Project.new
end

def create
#  @project = Project.create!(params[:project])
#  flash[:notice] = "#{@project.title} was successfully created."
end

def destroy

end

end