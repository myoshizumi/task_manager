# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = current_user.tasks.includes([:labels])
    if status_params = params.dig(:task, :status).presence
      @tasks = @tasks.task_status(status_params)
    end
    if search_params = params.dig(:task, :search).presence
      @tasks = @tasks.task_search(search_params)
    end
    if label_params = params.dig(:task, :label_id).presence
      @tasks = @tasks.joins(:labels).task_label(label_params)
    end
    @tasks = @tasks.order(expired_at: :desc) if params[:sort_expired]
    @tasks = @tasks.order(priority: :asc) if params[:sort_priority]
    @tasks = @tasks.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'タスクを登録しました。'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'タスクを編集しました。'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'タスクを削除しました。'
  end

  private

  def task_params
    params.require(:task).permit(:name, :detail, :expired_at, :status, :priority, { label_ids: [] })
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
