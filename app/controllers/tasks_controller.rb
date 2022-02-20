class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  
  def index
      @tasks = Task.all.created_order
    if params[:task].present? 
      if status_params.present? && search_params.present?
        # @tasks = Task.task_status
        @tasks = Task.where(status: status_params)
        # @tasks = @tasks.task_search
        @tasks = @tasks.where('name LIKE ?', "%#{search_params}%")
      elsif search_params.present? 
        # @tasks = @tasks.task_search
        @tasks = @tasks.where('name LIKE ?', "%#{search_params}%")
      elsif status_params.present?
        # @tasks = Task.task_status
        @tasks = Task.where(status: status_params)
      end
    elsif params[:sort_expired]
      @tasks = Task.all.order(expired_at: :desc)
    else
      @tasks = Task.all.created_order
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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
    params.require(:task).permit(:name, :detail, :expired_at, :status)
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
