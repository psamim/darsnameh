class Mailer < ActionMailer::Base
  include Helper

  default from: "samim@sandbox175821ce2bc7404e8a48d3d8b11e3630.mailgun.org"

  def welcome
    welcome_email = mail to: "psamim@gmail.com", subject: "Success! You did it."
    welcome_email.deliver
  end

  def send_next_lesson(user, course)
    next_lesson = Helper.next_lesson user, course
    next_lesson_mail = mail to: user.email, subject: next_lesson.title
    next_lesson_mail.deliver
  end

  def send_status(user)
    @courses = user.courses
    status_mail = mail to: user.email, subject: "Your status"
    status_mail.deliver
  end

  def send_command_not_found
  end

  def send_enrollment_confirmation(user, course)
    code = rand(1000...9999)
    @enrollment  = user.enrollments.create course: course, code: code, user: user
    confirmation_mail = mail to: user.email, subject: "Confirm your enrollment in " + course.title
    confirmation_mail.deliver
  end
end
