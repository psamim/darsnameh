class AdminController < ApplicationController

  def change_password
    @admin = Admin.find session[:admin_id]
    return unless admin_params[:current_password]

    if @admin.authenticate admin_params[:current_password] and
        admin_params[:new_password] == admin_params[:password_confirmation]
      @admin.password = admin_params[:new_password]
      redirect_to courses_path and flash[:notice] = 'Password changed' if @admin.save
    end
  end

  private

  def admin_params
    params.permit :current_password, :new_password, :password_confirmation
  end
end
