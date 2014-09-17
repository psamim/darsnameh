class QuizController < ApplicationController
  include Helper
  require 'digest/sha1'

  before_action :get_secret, only: [:show, :correct]
  before_action :find_quiz, only: [:show, :correct]

  attr_accessor :quiz, :secret

  def show
      @questions = Question.where(lesson: quiz.lesson)
  end

  def correct
      quiz.grade = answers.select(&:correct).count
      quiz.save
      send_next_lesson
      # queue_next_quiz
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

  def answers
    answer_ids = params.require(:answers).map {|a| a[1]}
    Answer.find(answer_ids)
  end

  def get_secret
    self.secret = params[:secret]
  end

  def send_next_lesson
    NextLessonWorker.perform_async user.id, course.id
  end

  def queue_next_quiz
    next_quiz = Helper.create_quiz user, Helper.next_lesson(user, course)
    NextQuizWorker.perform_in lesson.duration_days.day, next_quiz.id
  end

  def find_quiz
    self.quiz = Quiz.where(secret: secret).first
    unless self.quiz
      render plain: "Not found"
      return false
    end
    render plain: "Expired" if self.quiz.expire < Time.now
  end
end
