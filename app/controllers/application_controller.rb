class ApplicationController < ActionController::Base

  protect_from_forgery
  before_action :authenticate_user!

  # rescue_from CanCan::AccessDenied do |exception|
  #   flash[:alert] =  "You are not authorized to access it!!"
  #   redirect_to user_projects_path(current_user.id), flash[:alert] => exception.message
  # end

  def after_sign_in_path_for(resource)
    user_projects_path(current_user.id)
    if current_user.type == "Manager"
      user_developer_stats_path(current_user.id)
    elsif current_user.type == "Developer"
      user_projects_path(current_user.id)
    end
  end
end
