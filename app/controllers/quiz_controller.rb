class QuizController < ApplicationController
  include Helper
  require 'digest/sha1'

  def show
    q = Quiz.where(secret: secret).first
    @questions = Question.where(lesson: q.lesson)
  end

  def correct
    @quiz = Quiz.where(secret: secret).first
    if @quiz.expire > Time.now
      @quiz.grade = answers.select(&:correct).count
      @quiz.save

      send_next_lesson
      queue_next_quiz

      render json: grade
    else
      # It is expired
    end
  end

  private
  def user
    @quiz.user
  end

  def course
    @quiz.lesson.course
  end

  def answers
    answer_ids = params.require(:answers).map {|a| a[1]}

    Answer.find(answer_ids)
  end

  def secret
    params.require(:secret)
  end

  def send_next_lesson
    Mailer.send_next_lesson user, course
  end

  def queue_next_quiz
    next_quiz = Helper.create_quiz user, Helper.next_lesson(user, course)
    next_quiz
  end
end
