require 'rails_helper'

RSpec.describe Helper, :type => :helper do
  context 'having one user enrolled in a course' do
    let(:course) { create(:course) }
    let(:user) { create(:user) }
    let(:lesson_one) { create(:lesson) }
    let(:lesson_two) { create(:lesson) }
    before do
      user.courses << course
      course.lessons <<  lesson_one
      course.lessons <<  lesson_two
    end

    context 'when no quiz is taken' do
      it 'gives the first lesson' do
        expect(Helper.next_lesson(user, course)).to eq(lesson_one)
      end
    end

    context 'when quiz for lesson one is taken' do
      before do
        create(:quiz, lesson: lesson_one, user: user, grade: 100)
      end
      it 'give the second lesson' do
        expect(Helper.next_lesson(user, course)).to eq(lesson_two)
      end
    end
  end
end
