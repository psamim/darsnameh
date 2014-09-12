class AccessController < ApplicationController
  # before_action :confirm_logged_in, :except => [:login, :logout, :confirm_logged_in]
  layout "out"

  def login
    puts "AAAA"
    @user = User.new
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out successfuly"
    redirect_to :action => :login
  end

  def attempt_login
    if access_params[:email].present? && access_params[:password].present?
      user = User.where(:email => access_params[:email]).first
      if (user)
        auth_user = user.authenticate access_params[:password]
      end
    end
    if (auth_user)
      session[:user_id] = auth_user.id
      redirect_to courses_path
    else
      flash[:notice] = access_params[:email]
      redirect_to :action => :login
    end
  end

  private

  def access_params
    params.require(:user).permit(:email, :password)
  end
end
