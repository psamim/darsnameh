class AccessController < ApplicationController
  layout "out"

  def welcome
  end

  def login
    @admin = Admin.new
  end

  def logout
    session[:admin_id] = nil
    flash[:notice] = "Logged out successfuly"
    redirect_to :action => :login
  end

  def attempt_login
    if access_params[:email].present? && access_params[:password].present?
      admin = Admin.where(:email => access_params[:email]).first
      if (admin)
        auth_admin = admin.authenticate access_params[:password]
      end
    end
    if (auth_admin)
      session[:admin_id] = auth_admin.id
      redirect_to courses_path
    else
      redirect_to :action => :login
    end
  end

  private

  def access_params
    params.require(:admin).permit(:email, :password)
  end
end
