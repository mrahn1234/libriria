class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery with: :exception
  # include SessionsHelper
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email,:password])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :password])
    end



    # Confirms a logged-in user.
    # def logged_in_user
    #   unless logged_in?
    #     store_location
    #     flash[:danger] = "Please log in."
    #     redirect_to login_url
    #   end
    # end

    # def current_request
    #     if session[:request_id]
    #       Request.find(session[:request_id])
    #     else
    #       current_user.requests.build
    #     end
    # end
end