class CoursesController < ApplicationController
  # layout false
  before_action :confirm_logged_in
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  attr_accessor :course

  def index
    @courses = Course.all
    @page_header = "All Courses"
  end

  def show
    course.update(visible: !course.visible) if params[:toggle_visible]
    @page_header = course.title
  end

  def new
    self.course = Course.new
    @page_header = "Add a New Course"
  end

  def create
    self.course = Course.new(course_params)
    if course.save
      redirect_to course, notice: 'Course created'
    else
      render :new
    end
  end

  def edit
    @page_header = "Edit " + course.title
  end

  def update
    if course.update(course_params)
      redirect_to course, notice: 'Course updated'
    else
      render :edit
    end
  end

  def destroy
    course.destroy
    redirect_to courses_url, notice: 'Course deleted'
  end

  private

  def course_params
    params.require(:course).permit(:title, :intro, :email, :duration_days)
  end

  def set_course
    self.course = Course.find params[:id]
  end
end
