class ConfirmationWorker
  include Sidekiq::Worker

  def perform(user_id, course_id)
    user = User.find user_id
    course = Course.find course_id
    Mailer.send_enrollment_confirmation user, course
  end
end
