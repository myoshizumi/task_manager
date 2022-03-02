class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  
  def index
    @tasks =current_user.tasks.includes(:user)
    if status_params =params.dig(:task, :status).presence
      @tasks = @tasks.task_status(status_params)
    end
    if search_params =params.dig(:task, :search).presence
      @tasks = @tasks.task_search(search_params)
    end
    if label_params =params.dig(:task, :label_id).presence
      @tasks = @tasks.joins(:labels).task_label(label_params)
    end
    if params[:sort_expired]
      @tasks = @tasks.order(expired_at: :desc)
    end
    if params[:sort_priority]
      @tasks = @tasks.order(priority: :asc)
    end
    @tasks = @tasks.page(params[:page]).per(10)
  end
  # def index
  #   @tasks = current_user.tasks.includes(:user).page(params[:page]).per(5)
  #   if params[:task].present? 
  #     if status_params.present? && search_params.present?
  #       @tasks = Task.task_status(status_params).page(params[:page]).per(5)
  #       @tasks = @tasks.task_search(search_params).page(params[:page]).per(5)
  #     elsif search_params.present? 
  #       @tasks = @tasks.task_search(search_params).page(params[:page]).per(5)
  #     elsif status_params.present?
  #       @tasks = Task.task_status(status_params).page(params[:page]).per(5)
  #     elsif label_params.present?
  #       @tasks = @tasks.joins(:labels).task_label(label_params).page(params[:page]).per(5)
  #     end
  #   elsif params[:sort_expired]
  #     @tasks = current_user.tasks.order(expired_at: :desc).page(params[:page]).per(5)
  #   elsif params[:sort_priority]
  #     @tasks = current_user.tasks.order(priority: :asc).page(params[:page]).per(5)
  #   else
  #     @tasks = current_user.tasks.created_order.page(params[:page]).per(5)
  #   end
  # end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを登録しました。"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
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
    params.require(:task).permit(:name, :detail, :expired_at, :status, :priority, { label_ids: [] })
  end

  # def status_params
  #   params[:task][:status]
  # end

  # def search_params
  #   params[:task][:search]
  # end

  # def label_params
  #   params[:task][:label_id]
  # end

  def set_task
    @task = Task.find(params[:id])
  end
  
end
