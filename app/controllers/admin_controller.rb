class AdminController < ApplicationController

  def change_password
    @admin = Admin.find session[:admin_id]
    return unless admin_params[:current_password]

    if @admin.authenticate admin_params[:current_password]
      @admin.password = admin_params[:new_password]
      @admin.password_confirmation = admin_params[:password_confirmation]
      redirect_to courses_path and flash[:notice] = 'Password changed' if @admin.save
    end
  end

  private

  def admin_params
    params.permit :current_password, :new_password, :password_confirmation
  end
end
