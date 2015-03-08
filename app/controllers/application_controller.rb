  class ApplicationController < ActionController::Base

layout :layout_by_resource  

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :joined_family, if: '!devise_controller?'
  
  protected

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end

  def configure_permitted_parameters
	  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:user_name, :email, :password,:name,:password_confirmation) }
	  devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:user_name, :password) }
  end

  def joined_family    
    if !current_user.family      
      redirect_to join_a_family_home_path and return
    end
  end

end
