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
      grade = 0
      answers.each do |a|
        if Answer.find(a[1]).correct
          grade =+ 1
        end
      end
      @quiz.grade = grade
      @quiz.save
      render json: grade
      @user = @quiz.user
      @course = @quiz.lesson.course
      send_next_lesson
      queue_next_quiz
    else
      # It is expired
    end
  end

  private

  def answers
    params.require(:answers)
  end

  def secret
    params.require(:secret)
  end

  def send_next_lesson
    Mailer.send_next_lesson @user, @course
  end

  def queue_next_quiz
    next_quiz = Helper.create_quiz @user, Helper.next_lesson(@user, @course)
    next_quiz
  end
end
