module Helper
  def self.next_lesson(user, course)
    last_quiz = Quiz.joins(:lesson)
      .where(lessons: { course_id: course }, user_id: user).last
    return course.lessons.where(position: 1).first unless last_quiz
    last_lesson_position  = last_quiz.lesson.position
    next_lesson = Lesson.where(position: last_lesson_position + 1).first
    next_lesson
  end

  def self.create_quiz(user, lesson)
    q = Quiz.new(user: user, lesson: lesson)
    q.secret = Digest::SHA1.hexdigest Time.new.to_f.to_s + user.id.to_s
    q.expire = 2.day.from_now
    q.save
  end
end
