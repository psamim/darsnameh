require 'rails_helper'

RSpec.describe QuizController, type: :controller do

  describe 'Quizz' do
    before do
      # Sidekiq::
    end

    context '#show' do
      let(:quiz) do
        user = create(:user)
        lesson = create(:lesson)
        Quiz.create_quiz(user, lesson)
      end

      before do
        get :show, secret: quiz.secret
      end

      it 'assigns questions for the view' do
        questions = Question.where(lesson: quiz.lesson)
        expect(assigns(:questions)).to eq(questions)
      end
    end

    context '#result' do
      let(:quiz) do
        user = create(:user)
        lesson = create(:lesson)
        create(:lesson)
        question1 = create(:question, lesson: lesson)
        create(:answer, question: question1)
        question2 = create(:question, lesson: lesson)
        create(:answer, question: question2)
        question3 = create(:question, lesson: lesson)
        create(:answer, question: question3)
        question4 = create(:question, lesson: lesson)
        create(:answer, question: question4)
        Quiz.create_quiz(user, lesson)
      end

      let(:answers) do
        quiz.lesson.questions.map { |q| q.answers.first.id }
      end

      it 'gives the grade 25 if one fourth is answered' do
        get :result,
            secret: quiz.secret,
            answers: [[nil, [answers[0]]]]
        expect(quiz.reload.grade).to eq(25)
      end

      context 'when failing the text' do
        it 'renders failed' do
          get :result,
              secret: quiz.secret,
              answers: [[nil, [answers[0]]],
                        [nil, [answers[1]]]]
          expect(response).to render_template(:failed)
        end

        it 'sends another quiz for the current lesson'
      end

      context 'when passing the quiz' do
        it 'renders the grade template'
        it 'sends the next lesson if it has next lesson'
        it 'sends course is finished if it is the last lesson'
      end
    end
  end
end
