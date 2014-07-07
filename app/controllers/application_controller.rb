class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :admin_user?
  helper_method :correct_or_admin_user?

  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end

    def admin_user?
      if current_user.admin?
        flash.now[:notice] = 'You are viewing an admin only page. Proceed with caution'
      else
        redirect_to root_url, alert: 'Access denied.'
      end
    end

    def correct_or_admin_user?
      if !@user && @player
        @user = @player.user
      end
      unless current_user && (current_user == @user || current_user.admin?)
        redirect_to root_url, alert: 'Access denied.'
      end
    end

end
