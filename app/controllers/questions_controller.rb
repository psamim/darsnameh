class QuestionsController < ApplicationController
  before_action :confirm_logged_in
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :build_question, only: [:create, :new]

  attr_accessor :question, :page_header

  def new
    @question = Question.new
    @question.lesson = Lesson.find params[:lesson_id]
    self.page_header = "New Question"
    4.times { question.answers.build }
  end

  def create
    redirect_to lesson_path question.lesson.id if question.save
  end

  def show
    self.page_header = question.lesson.title
  end

  def edit
    self.page_header = "Edit Question"
  end

  def update
    question.answers.destroy_all
    question.update(question_params)
    redirect_to lesson_path question.lesson.id
  end

  def destroy
    question.destroy
    redirect_to lesson_path question.lesson
  end

  private
  def build_question
    self.question = Question.new(question_params)
  end

  def find_question
    self.question = Question.find params[:id]
  end

  def question_params
    permitted_params = params.fetch(:question, Hash.new)
      .permit(:text, :lesson_id, answers_attributes: [:text, :correct])

    permitted_params.merge(lesson_id: params[:lesson_id]) unless params[:lesson_id].nil?

    permitted_params
  end
end
