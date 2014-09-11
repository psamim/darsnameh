class LessonsController < ApplicationController
  def new
    @lesson = Lesson.new
    @page_header = "Add a New Course"
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.course = Course.find params[:course_id]
    if @lesson.save
      redirect_to course_path @lesson.course
    end
  end

  def show
    @lesson = Lesson.find params[:id]
    @page_header = @lesson.title
  end

  def destroy
    @lesson = Lesson.find params[:id]
    @lesson.destroy
    redirect_to course_path @lesson.course
  end

  def edit
    @lesson = Lesson.find params[:id]
    @page_header = "Edit " + @lesson.title
  end

  def update
    @lesson = Lesson.find params[:id]
    @lesson.update(lesson_params)
    redirect_to course_path @lesson.course
  end

  private

  def lesson_params
    params.require(:lesson).permit(:title, :text)
  end
end

