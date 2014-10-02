require 'rails_helper'

RSpec.describe Course, type: :model do
  context 'at first' do
    it 'should not create a course without email' do
      course_attributes = attributes_for(:course)
      course_attributes[:email] = nil
      expect(Course.new(course_attributes)).to have_at_least(1).error_on(:email)
    end

    it 'should not create a course without title' do
      course_attributes = attributes_for(:course)
      course_attributes[:title] = nil
      expect(Course.new(course_attributes)).to have_at_least(1).error_on(:title)
    end
  end
end
