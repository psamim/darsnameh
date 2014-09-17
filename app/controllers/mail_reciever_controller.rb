class MailRecieverController < ApplicationController
  def on_incoming_email
    command = /.+(?=@)/.match(email_params[:recipient]).to_s
    case command
      when "status"
        render plain: "Yes"
    else
      course = Course.find_by_email command
      if course
        render json: course.title
      else
        render plain: command
      end
    end
    # See if sender is a user
    # Get the command
    # Else see if it is a course
    # Register the user in course
    send_enrollment_confirmation
  end

  private
  def email_params
    params.permit :sender, :recipient, :subject, "body-plain", "stripped-text"
  end

  def send_enrollment_confirmation
  end
end
