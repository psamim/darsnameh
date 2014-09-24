class NextLessonWorker
  include Sidekiq::Worker

  def perform(user_id, course_id)
    user = User.find user_id
    course = Course.find course_id
    Mailer.send_next_lesson(user, course).deliver
  end
end
