class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  
  def index
    @tasks = current_user.tasks.page(params[:page]).per(5)
    if params[:task].present? 
      if status_params.present? && search_params.present?
        @tasks = Task.task_status(status_params).page(params[:page]).per(5)
        @tasks = @tasks.task_search(search_params).page(params[:page]).per(5)
      elsif search_params.present? 
        @tasks = @tasks.task_search(search_params).page(params[:page]).per(5)
      elsif status_params.present?
        @tasks = Task.task_status(status_params).page(params[:page]).per(5)
      end
    elsif params[:sort_expired]
      @tasks = current_user.tasks.order(expired_at: :desc).page(params[:page]).per(5)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order(priority: :asc).page(params[:page]).per(5)
    else
      @tasks = current_user.tasks.created_order.page(params[:page]).per(5)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    # @task.user_id = current_user.id
    if @task.save
      redirect_to tasks_path, notice: "タスクを登録しました。"
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました。"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:name, :detail, :expired_at, :status, :priority)
  end

  def status_params
    params[:task][:status]
  end

  def search_params
    params[:task][:search]
  end

  def set_task
    @task = Task.find(params[:id])
  end
  
end
