module Helper
  def Helper.next_lesson(user, course)
    last_quiz = Quiz.joins(:lesson).where(lessons: {course_id: course}, user_id: user).last
    last_lesson_position  = last_quiz.lesson.position
    next_lesson = Lesson.where(position: last_lesson_position + 1)
    return next_lesson
  end

  def Helper.create_quiz(user, lesson)
    q =Quiz.new(user: user, lesson: lesson)
    q.secret = Digest::SHA1.hexdigest Time.new.to_f.to_s + user.id.to_s
    q.expire = 2.day.from_now
    q.save
    return q
  end
end
