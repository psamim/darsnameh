module Helper
  def self.next_lesson(user, course)
    last_quiz = Quiz.joins(:lesson)
      .where(%{
             'lessons'.'course_id' = :course_id
             AND 'quizzes'.'user_id' = :user_id
             AND ('quizzes'.'grade' IS NOT NULL)
             },
             { user_id: user.id, course_id: course.id })
    .last
    return course.lessons.where(position: 1).first unless last_quiz
    last_lesson_position  = last_quiz.lesson.position
    next_lesson = Lesson.where(position: last_lesson_position + 1).first
    next_lesson
  end

  def self.create_quiz(user, lesson)
    quiz = Quiz.new(user: user, lesson: lesson)
    quiz.secret = Digest::SHA1.hexdigest Time.new.to_f.to_s + user.id.to_s
    quiz.expire = 2.day.from_now
    quiz.save
  end

  def self.queue_next_quiz(user, course)
    next_quiz = Helper.create_quiz user, Helper.next_lesson(user, course)
    NextQuizWorker.perform_async next_quiz.id
  end
end
