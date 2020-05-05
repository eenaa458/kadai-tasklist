class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in, only: [:show, :create, :update, :delete]
  
  def index
    if logged_in?
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    else
      redirect_to("/login")
    end
  end
  
  def show
  end
  
  def new
    @task = current_user.tasks.build
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に作成されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが作成されませんでした'
      render :new
    end
  end
  
  def edit
    unless @task
      redirect_to root_url
    end
  end
  
  def update
    
    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = current_user.tasks.find_by(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
