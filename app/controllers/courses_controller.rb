class CoursesController < ApplicationController
  layout false
  def index
    @courses = Course.all
  end

  def show
    @id = params[:id]
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to(:action => 'show')
    end
    # TODO
  end

  private

  def course_params
    params.require(:course).permit(:title, :intro)
  end
end
