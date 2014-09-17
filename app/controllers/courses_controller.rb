class CoursesController < ApplicationController
  # layout false
  before_action :confirm_logged_in
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.all
    @page_header = "All Courses"
  end

  def show
    @page_header = @course.title
  end

  def new
    @course = Course.new
    @page_header = "Add a New Course"
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course, notice: 'Course created'
    else
      render :new
    end
  end

  def edit
    @page_header = "Edit " + @course.title
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: 'Course updated'
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_url, notice: 'Course deleted'
  end

  private

  def course_params
    params.require(:course).permit(:title, :intro, :email, :duration_days)
  end

  def set_course
    @course = Course.find params[:id]
  end
end
