class MailRecieverController < ApplicationController
  before_action :set_user, only: :on_incoming_email
  before_action :set_command, only: :on_incoming_email
  attr_accessor :user, :command

  def on_incoming_email
    user.save
    case command
      when "status"
        render plain: "Status mail sent to  " + user.email + " with ID " + user.id.to_s
        send_status_mail
    else
      course = Course.find_by_email command
      if course
        render plain: "Confirmation code for " + course.id.to_s + " sent to " + user.email
        send_enrollment_confirmation_mail course
      else
        render plain: command
        send_command_not_found_mail
      end
    end
  end

  private
  def email_params
    params.permit :sender, :recipient, :subject, "body-plain", "stripped-text"
  end

  def set_user
    self.user = User.find_by_email email_params[:sender]
    unless  self.user
      self.user = User.new
      self.user.email = email_params[:sender]
    end
  end

  def set_command
    self.command= /.+(?=@)/.match(email_params[:recipient]).to_s
  end

  def send_enrollment_confirmation_mail(course)
    ConfirmationWorker.perform_async user.id, course.id
  end

  def send_command_not_found_mail
  end

  def send_status_mail
    StatusWorker.perform_async user.id
  end
end
