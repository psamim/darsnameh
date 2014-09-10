class CoursesController < ApplicationController
  # layout false
  def index
    @courses = Course.all
    @page_header = "All Courses"
  end

  def show
    @course = Course.find params[:id]
    @page_header = @course.title
  end

  def new
    @course = Course.new
    @page_header = "Add a New Course"
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to(:action => 'index')
    end
    # TODO
  end

  def destroy
    @course = Course.find params[:id]
    @course.destroy
    redirect_to :action => 'index'
  end

  private

  def course_params
    params.require(:course).permit(:title, :intro)
  end
end
