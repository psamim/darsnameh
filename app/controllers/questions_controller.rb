class QuestionsController < ApplicationController
  before_action :confirm_logged_in

  def destroy
    @question = Question.find params[:id]
    @question.destroy
    redirect_to lesson_path @question.lesson
  end

  def new
    @page_header = "New Question"
    @question = Question.new
    4.times { @question.answers.build}
  end

  def create
    @question = Question.new(question_params)
    @question.lesson = Lesson.find params[:lesson_id]
    if @question.save
      redirect_to lesson_path params[:lesson_id]
    end
  end

  def show
    @q = Question.find params[:id]
    @page_header = @q.lesson.title
  end

  def edit
    @question = Question.find params[:id]
    @page_header = "Edit Question"
  end

  def update
    @question = Question.find params[:id]
    @question.answers.destroy_all
    @question.update(question_params)
    redirect_to lesson_path @question.lesson
  end

  private

  def question_params
    params.require(:question).permit(:text, answers_attributes: [:text, :correct])

  end
end
