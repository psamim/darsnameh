class Mailer < ActionMailer::Base
  include Helper

  default from: 'samim@sandbox175821ce2bc7404e8a48d3d8b11e3630.mailgun.org'
  default_url_options[:host] = 'localhost:3000'

  def send_lesson(user, lesson)
    @lesson = lesson
    mail to: user.email,
         subject: @lesson.title
  end

  def send_status(user)
    @courses = user.courses.where(enrollments: { confirmed: true })
    mail to: user.email,
         subject: 'Your status'
  end

  def send_command_not_found
  end

  def send_enrollment_confirmation(user, course)
    code = rand(10_000...99_999)
    @enrollment  = user.enrollments
      .create course: course, code: code, user: user
    mail to: user.email,
         subject: "Confirm your enrollment in  #{course.title}"
  end

  def send_welcome(user, course)
    @course = course
    mail to: user.email,
         subject: "Welcome to #{course.title}"
  end

  def send_quiz(quiz)
    @quiz = quiz
    mail to: quiz.user.email,
         subject: "Quiz for #{quiz.lesson.title}"
  end

  def send_course_finished(user, course)
    @course = course
    mail to: user.email,
         subject: "You finished #{course.title}"
  end

  def send_all_courses(user)
    @courses = Course.where(visible: true)
    mail to: user.email,
         subject: "List of Courses"
  end
end
