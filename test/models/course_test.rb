require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test 'should not create course without title' do
    course_attributes = attributes_for(:course)
    course_attributes[:email] = nil
    assert Course.new(course_attributes).invalid?(:email)
  end
end
