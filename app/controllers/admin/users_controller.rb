class Admin::UsersController < ApplicationController
  # before_action :admin_exist, only: %i[destroy]
  before_action :set_user, only: %i[show edit update destroy]
  before_action :only_admin

  def new
    @user = User.new
  end

  def index
    @users = User.select(:id, :name).page(params[:page]).per(5)
  end

  def create
    @user = User.new(user_params)
    if @user.save  && current_user.admin?
      redirect_to admin_users_path, notice: "ユーザーを新規登録しました。"
    else
      render :new
    end
  end

  def show
    @tasks = User.find(params[:id]).tasks.page(params[:page]).per(5)
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

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def only_admin
    redirect_to root_path, notice: "管理者以外はアクセスできません！" unless current_user.admin?
  end
end
