class LessonsController < ApplicationController
  def new
    @lesson = Lesson.new
    @page_header = "Add a New Course"
  end

  def create
    @lesson = Lesson.new(course_params)
    @lesson.course = Course.find params[:course_id]
    if @lesson.save
      redirect_to(:action => 'index', :controller=> 'courses')
    end
  end

  def show
    @lesson = Lesson.find params[:id]
    @page_header = @lesson.title
  end

  def destroy
    @lesson = Lesson.find params[:id]
    @lesson.destroy
    redirect_to :action => 'index'
  end

  private

  def course_params
    params.require(:lesson).permit(:title, :text)
  end
end

