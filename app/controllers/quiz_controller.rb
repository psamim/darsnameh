class QuizController < ApplicationController
  include Helper
  require 'digest/sha1'

  before_action :find_secret, only: [:show, :correct]
  before_action :find_quiz, only: [:show, :correct]

  attr_accessor :quiz, :secret

  def show
    @questions = Question.where(lesson: quiz.lesson)
  end

  def correct
    quiz.grade = answers.select(&:correct).count
    quiz.save
    send_next_lesson
    Helper.queue_next_quiz
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
    answer_ids = params.require(:answers).map { |a| a[1] }
    Answer.find(answer_ids)
  end

  def find_secret
    self.secret = params[:secret]
  end

  def send_next_lesson
    NextLessonWorker.perform_async user.id, course.id
  end

  def find_quiz
    self.quiz = Quiz.where(secret: secret).first
    unless quiz
      render plain: 'Not found'
      return false
    end
    render plain: 'Expired' if quiz.expire < Time.now
  end
end
