class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :only_admin

  def new
    @user = User.new
  end

  def index
    @users = User.all.page(params[:page]).per(5)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
  end

  def edit 
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザーを編集しました。"
    else
      render :edit
    end
  end

  def destroy
    # @user.tasks.user.destroy
    @user.destroy 
    redirect_to admin_users_path, notice: "ユーザーを削除しました。"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def only_admin
    redirect_to root_path, notice: "管理者以外はアクセスできません！" unless current_user.admin?
  end
end
