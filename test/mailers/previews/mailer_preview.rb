# Preview all emails at http://localhost:3000/rails/mailers/mailer
class MailerPreview < ActionMailer::Preview
  def status
    Mailer.send_status(User.find(6))
  end

  def quiz
    Mailer.send_quiz(Quiz.find(7))
  end
end
