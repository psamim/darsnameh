class WelcomeWorker
  include Sidekiq::Worker

  def perform(user_id, course_id)
    user = User.find user_id
    course = Course.find course_id
    Mailer.send_welcome user, course
    Mailer.send_next_lesson user, course
    Helper.queue_next_quiz user, course
  end
end
