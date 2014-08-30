class ProjectsController < ApplicationController

def index
  @projects = Project.all
end

def new
  @project = Project.new
end

def edit
  @project = Project.find(params[:id])
end

def update
  @project = Project.find(params[:id])
  if @project.update_attributes(project_params)
  	flash[:success] = "Project updated"
  	redirect_to root_path
  else
  	render 'edit'
  end
end

def create
  @project = Project.new(project_params)
  if @project.save
  	flash[:notice] = "#{@project.title} was successfully created."
  	redirect_to root_path
  else
    render 'new'
  end
end

def destroy
	Project.find(params[:id]).destroy
    flash[:success] = "Project deleted."
    redirect_to root_path
end

private
	
	def project_params
	  params.require(:project).permit(:title)
	end

end