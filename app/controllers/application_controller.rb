class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def set_current_user
    puts("YYYYYYYYYYYYYYYYYYYYYYYYYYY")
    @current_user = User.find_by session_token: (session[:session_token])
    if !@current_user.nil? 
      @display_name = @current_user[:user_id]
    else
      puts("XXXXXXXXXXXXXXXXXXXXXXXXXXXX")
    end
  end
  before_filter :set_current_user


  def check_login
    if @current_user.nil?
      flash[:warning] = "You must be logged in to do that"
      redirect_to login_path and return
    else
      return true
    end
  end
end
