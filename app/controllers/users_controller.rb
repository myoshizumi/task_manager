class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[new create]
  before_action :login_user, only: %i[new]
  before_action :user_only, only: %i[show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    # elsif @user.save && current_user.admin
    #   redirect_to admin_users_path, notice: "ユーザーを新規登録しました。"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = User.find(params[:id]).tasks.page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: "ユーザーを編集しました。"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def login_user
    redirect_to tasks_path if current_user
  end
  
  def user_only
    redirect_to tasks_path unless current_user == User.find(params[:id]) || current_user.admin
  end
end
