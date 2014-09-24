class CourseFinishedWorker
  include Sidekiq::Worker

  def perform(user_id, course_id)
    user = User.find user_id
    course = Course.find course_id
    Mailer.send_course_finished(user, course).deliver
  end
end
