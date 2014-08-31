class TasksController < ApplicationController
  
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(task_params)
    if @task.save
      flash[:success] = "Task created!"
      #respond_to do |format|
        #format.html { 
        redirect_to root_path #}
#        format.js
 #     end
    else
      flash[:error] = "Name of a task can not be blank!"
      redirect_to root_path
    end
  end

  def do
    @task = Task.find(params[:id])
    @task.update(status: "Done")
    redirect_to root_path
  end

  def undo
    @task = Task.find(params[:id])
    @task.update(status: "New")
    redirect_to root_path
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "Task updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    flash[:success] = "Task deleted."
    redirect_to root_path
  end

  def up
    task = Task.find(params[:id])
    if task.promote
    then flash[:success] = "Task's priority was increased"
    else flash[:error] = "Something went wrong"
    end
    redirect_to root_path
  end

  def down
    task = Task.find(params[:id])
    if task.demote
    then flash[:success] = "Task's priority was decreased"
    else flash[:error] = "Something went wrong"
    end
    redirect_to root_path
  end

  private

    def task_params
      params.require(:task).permit(:name, :status, :deadline, :priority)
    end
end