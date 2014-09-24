class LessonWorker
  include Sidekiq::Worker

  def perform(user_id, lesson_id)
    user = User.find user_id
    lesson = Lesson.find lesson_id
    Mailer.send_lesson(user, lesson).deliver
  end
end
