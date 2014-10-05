module Helper
  def self.next_lesson(user, course)
    last_quiz = Quiz.joins(:lesson)
      .where.not(grade: nil)
      .where(lessons: { course_id: course }, user: user)
      .order(:created_at)
      .last
    return course.lessons.order(:position).first unless last_quiz
    last_lesson_position  = last_quiz.lesson.position
    next_lesson = Lesson.where(position: last_lesson_position + 1).first
    next_lesson
  end

  def self.queue_next_quiz(user, lesson)
    next_quiz = Quiz.create_quiz user, lesson
    QuizWorker.perform_async next_quiz.id
  end
end
