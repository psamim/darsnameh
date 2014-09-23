class MailRecieverController < ApplicationController
  before_action :set_user, only: :on_incoming_email
  before_action :set_command, only: :on_incoming_email
  attr_accessor :user, :command
  layout false

  def on_incoming_email
    if command == 'status' && user
      send_status_mail
      return
    end

    # See if it is a enrollment confirmation mail
    code = /\d{4}/.match(email_params['stripped-text']).to_s || 99_999
    enrollment = Enrollment.where(code: code, user: user).first
    if enrollment # && !enrollment.confirmed
      enrollment.confirmed = true
      enrollment.save
      send_welcome_mail user, enrollment.course
      return
    end

    # See if it is a course enrollment mail
    course = Course.find_by_email command
    if course
      send_enrollment_confirmation_mail user, course
      return
    end

    send_command_not_found_mail
    render plain: command + ' not found'
  end

  private

  def email_params
    params.permit :sender, :recipient, :subject, 'body-plain', 'stripped-text'
  end

  def set_user
    self.user = User.find_by_email email_params[:sender]
    return if user
    self.user = User.new
    user.email = email_params[:sender]
    user.save
  end

  def set_command
    self.command = /.+(?=@)/.match(email_params[:recipient]).to_s
  end

  def send_enrollment_confirmation_mail(user, course)
    ConfirmationWorker.perform_async user.id, course.id
    render plain:
    'Confirmation code for ' + course.id.to_s + ' sent to ' + user.email
  end

  def send_command_not_found_mail
  end

  def send_status_mail
    StatusWorker.perform_async user.id
    render plain:
    'Status mail sent to  ' + user.email + ' with ID ' + user.id.to_s
  end

  def send_welcome_mail(user, course)
    # WelcomeWorker.perform_async user.id, course.id
    WelcomeWorker.new.perform user.id, course.id
    render plain:
    'Welcome mail sent to  ' + user.email + ' with ID ' + user.id.to_s
  end
end
