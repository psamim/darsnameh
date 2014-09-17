class Mailer < ActionMailer::Base
  include Helper

  default from: "samim@sandbox175821ce2bc7404e8a48d3d8b11e3630.mailgun.org"

  def welcome
    mail to: "psamim@gmail.com", subject: "Success! You did it."
  end

  def send_next_lesson(user, course)
    next_lesson = Helper.next_lesson user, course
    mail to: user.email, subject: next_lesson.title
  end
end
