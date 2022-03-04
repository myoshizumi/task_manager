class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required

  # rescue_from ActiveRecord::RecordNotFound,   with: :render_404
    # rescue_from ActionController::RoutingError, with: :render_404
  private
 
  # def render_404
  #   redirect_to tasks_path
  # end

  def login_required
    redirect_to new_session_path unless current_user
  end
end
