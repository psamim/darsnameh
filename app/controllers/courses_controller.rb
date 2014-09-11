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
      redirect_to courses_path
    end
    # TODO
  end

  def edit
    @course = Course.find params[:id]
    @page_header = "Edit " + @course.title
  end

  def update
    @course = Course.find params[:id]
    @course.update(course_params)
    redirect_to courses_path
  end

  def destroy
    @course = Course.find params[:id]
    @course.destroy
    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit(:title, :intro)
  end
end
