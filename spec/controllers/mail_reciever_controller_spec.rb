# coding: utf-8
require 'rails_helper'

RSpec.describe MailRecieverController, type: :controller do
  describe 'on email coming' do
    let(:command) { 'test-command' }
    let(:sender) { 'user@example.com' }
    let(:text) { 'test-text' }
    let(:mail_subject) { 'test-subject' }
    let(:course) do
      course = create(:course)
      create_list(:lesson, 2, course: course)
      course
    end

    before do
      get :on_incoming_email,
          recipient: "#{command}@example.com",
          sender: sender,
          'stripped-text' => "#{text}",
          'body-plain' => ".#{text}.",
          subject: mail_subject

    end

    it 'finds the commmand' do
      expect(assigns(:command)).to eq(command)
    end

    context 'when user is registered' do
      let(:user) { create(:user) }
      let(:sender) { user.email }

      it 'finds the user' do
        expect(assigns(:user).email).to eq(user.email)
      end
    end

    context 'when user is new' do
      it 'creates a user' do
        expect(assigns(:user).email).to eq(sender)
      end
    end

    context 'when command is `status`' do
      let(:command) { 'status' }
      let(:mail_subject) { 'test' }

      it 'sends enrolled courses to the user' do
        expect(StatusWorker).to have_enqueued_job(assigns(:user).id)
      end
    end

    context 'when it is an enrollment confirmation mail' do
      let(:user) { create(:user) }
      let(:sender) { user.email }
      let(:enrollment) { create(:enrollment, course: course, user: user, code: 12345) }
      let(:text) { enrollment.code }

      it 'finds the confirmation code' do
        expect(assigns(:enrollment).code).to eq(enrollment.code)
      end

      it 'enrolls the user in course' do
        expect(user.courses).to include(course)
      end

      it 'sends welcome mail to the user' do
        expect(WelcomeWorker).to have_enqueued_job(user.id, course.id)
      end

      it 'sends first lesson to the user' do
        first_lesson = course.lessons.first
        expect(LessonWorker).to have_enqueued_job(user.id, first_lesson.id)
      end

      it 'queues first quiz for the user' do
        quiz = Quiz.where(user: user, lesson: course.lessons.first).first
        expect(QuizWorker).to have_enqueued_job(quiz.id)
      end
    end

    context 'when it is course enrollment request mail' do
      let(:user) { create(:user) }
      let(:sender) { user.email }
      let(:command) { course.email }

      it 'finds the course' do
        expect(assigns(:course).email).to eq(command)
      end

      it 'sends enrollment confirmation mail' do
        expect(ConfirmationWorker).to have_enqueued_job(
          user.id, course.id)
      end
    end

    context 'when command is `list`' do
      let(:command) { 'list' }
      let(:user) { create(:user) }
      let(:sender) { user.email }
      it 'sends all available courses' do
        expect(ListWorker).to have_enqueued_job(user.id)
      end
    end
  end
end
