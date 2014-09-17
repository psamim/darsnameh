class LessonsController < ApplicationController
  before_action :confirm_logged_in
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  def new
    @lesson = Lesson.new
    @lesson.course = Course.find params[:course_id]
    @page_header = "Add a New Lesson"
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.course = Course.find lesson_params[:course_id]
    if @lesson.save
      redirect_to @lesson, notice: 'Lesson created'
    else
      render :new
    end
  end

  def show
    @page_header = @lesson.title
  end

  def destroy
    @lesson.destroy
    redirect_to course_path @lesson.course
  end

  def edit
    @page_header = "Edit " + @lesson.title
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to @lesson, notice: 'Lesson updated'
    else
      render :edit
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit(:title, :text, :duration_days, :course_id)
  end

  def set_lesson
    @lesson = Lesson.find params[:id]
  end
end
