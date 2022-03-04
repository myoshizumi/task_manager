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
      redirect_to user_path(@user.id), notice: "ログインしました"
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to tasks_path
    else
    @tasks = @user.tasks.page(params[:page]).per(5)
    end
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
    redirect_to tasks_path unless current_user == User.find_by(id: params[:id]) 
  end
end
