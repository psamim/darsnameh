class QuizController < ApplicationController
  before_action :find_secret, only: [:show, :result]
  before_action :find_quiz, only: [:show, :result]
  before_action :find_next_lesson, only: [:result]

  attr_accessor :quiz, :secret, :next_lesson
  layout 'out'

  def show
    @questions = Question.where(lesson: quiz.lesson)
  end

  def result
    quiz.update(grade: grade)

    if quiz.grade < 60
      queue_quiz quiz.lesson
      render :failed
    elsif next_lesson
      send_lesson next_lesson
      queue_quiz next_lesson
    else
      send_course_finished
    end
  end

  private

  def user
    @quiz.user
  end

  def course
    @quiz.lesson.course
  end

  def lesson
    @quiz.lesson
  end

  def find_next_lesson
    self.next_lesson = Helper.next_lesson user, course
  end

  def answers
    answer_ids = params.require(:answers).map { |a| a[1] }
    Answer.find(answer_ids)
  end

  def find_secret
    self.secret = params[:secret]
  end

  def send_lesson(lesson)
    LessonWorker.perform_async user.id, lesson.id
  end

  def find_quiz
    self.quiz = Quiz.where(secret: secret).first
    unless quiz
      render plain: 'Not found'
      return false
    end
    render plain: 'Expired' if quiz.expire < Time.now || quiz.grade != nil
  end

  def queue_quiz(lesson)
    Helper.queue_next_quiz user, lesson
  end

  def send_course_finished
    CourseFinishedWorker.perform_async user, course
  end

  def grade
    answers.select(&:correct).size.fdiv(quiz.questions.size) * 100
  end
end
