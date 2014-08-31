class TasksController < ApplicationController
  
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(task_params)
    @task.status = "New"
    if @task.save
      flash[:success] = "Task created!"
      redirect_to root_path
    else
      render root_path
    end
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

  private

    def task_params
      params.require(:task).permit(:name, :status, :deadline, :priority)
    end
end