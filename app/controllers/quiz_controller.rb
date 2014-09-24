class QuizController < ApplicationController
  require 'digest/sha1'

  before_action :find_secret, only: [:show, :correct]
  before_action :find_quiz, only: [:show, :correct]
  before_action :find_next_lesson, only: [:correct]

  attr_accessor :quiz, :secret, :next_lesson

  def show
    @questions = Question.where(lesson: quiz.lesson)
  end

  def correct
    quiz.grade = answers.select(&:correct).count
    quiz.save

    if next_lesson
      send_next_lesson
      queue_next_quiz
    else
      send_course_finished
    end

    render json: quiz.grade
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

  def send_next_lesson
    LessonWorker.perform_async user.id, next_lesson.id
  end

  def find_quiz
    self.quiz = Quiz.where(secret: secret).first
    unless quiz
      render plain: 'Not found'
      return false
    end
    render plain: 'Expired' if quiz.expire < Time.now
  end

  def queue_next_quiz
    Helper.queue_next_quiz user, next_lesson
  end

  def send_course_finished
  end
end
