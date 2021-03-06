class TasksController < ApplicationController
  
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(task_params)
    if @task.save
      flash[:success] = %{Task "#{@task.name}" was created!}
      redirect_to root_path
    else
      flash[:error] = "Name of a task can not be blank!"
      redirect_to root_path
    end
  end

  def do
    @task = Task.find(params[:id])
    @task.update(status: "Done")
    render :nothing => true
  end

  def undo
    @task = Task.find(params[:id])
    @task.update(status: "New")
    render :nothing => true
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = %{Task "#{@task.reload.name}" updated}
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    task = Task.find(params[:id])
    higher_tasks = Task.where(%{project_id = #{task.project_id} and priority > #{task.priority}})
    flash[:success] = %{Task "#{task.name}" was deleted.}
    higher_tasks.each do |t|
      t.update(priority: t.priority - 1)
    end
    task.destroy
    redirect_to root_path
  end

  def up
    task = Task.find(params[:id])
    if task.promote
    then flash[:success] = %{Task "#{task.name}" priority was increased}
    else flash[:success] = %{Task "#{task.name}" already has highest priority!}
    end
    redirect_to root_path
  end

  def down
    task = Task.find(params[:id])
    if task.demote
    then flash[:success] = %{Task "#{task.name}" priority was decreased}
    else flash[:success] = %{Task "#{task.name}" already has lowest priority!}
    end
    redirect_to root_path
  end

  private

    def task_params
      params.require(:task).permit(:name, :status, :deadline, :priority)
    end
end