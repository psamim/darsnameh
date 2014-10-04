require 'rails_helper'

RSpec.describe QuizController, type: :controller do

  describe 'Quiz' do
    let(:user) { create(:user) }
    let(:course) { course = create(:course) }
    let(:lessons) { lessons = create_list(:lesson, 2, course: course) }
    let(:quiz) { Quiz.create_quiz(user, lessons[0]) }
    let(:answers) { quiz.lesson.questions.map { |q| q.answers.first.id } }

    before do
      user.courses << course
      lessons.each do |lesson| 
        questions = create_list(:question, 4, lesson: lesson)
        questions.each do |question| 
          create(:answer, question: question)
        end
      end
    end

    def correct_answers(number)
      answer_param = []
      (0...number).each do |n|
        answer_param << [nil, [answers[n]]]
      end
      answer_param
    end
     
    context '#show' do
      before do
        get :show, secret: quiz.secret
      end

      it 'assigns questions for the view' do
        questions = Question.where(lesson: quiz.lesson)
        expect(assigns(:questions)).to eq(questions)
      end
    end

    context '#result' do
      it 'gives the grade 25 if one fourth is answered' do
        get :result,
            secret: quiz.secret,
            answers: correct_answers(1)
        expect(quiz.reload.grade).to eq(25)
      end

      context 'when failing the test' do
        before do
          get :result,
              secret: quiz.secret,
              answers: correct_answers(2)
        end

        it 'renders failed' do
          expect(response).to render_template(:failed)
        end

        it 'sends another quiz for the current lesson' do
          current_lesson_quiz = Quiz.where(lesson: quiz.lesson, grade: nil).first
          expect(QuizWorker).to have_enqueued_job(current_lesson_quiz.id)
        end
      end

      context 'when passing the quiz' do
        before do
          get :result,
              secret: quiz.secret,
              answers: correct_answers(3)
        end

        it 'renders the grade template' do
          expect(response).to render_template(:result)
        end

        it 'sends the next lesson if it has next lesson' do
           next_lesson = Helper.next_lesson(quiz.user, quiz.lesson.course)
           expect(LessonWorker).to have_enqueued_job(quiz.user.id, next_lesson.id)
        end

        it 'sends the next lesson quiz' do
           next_lesson = Helper.next_lesson(quiz.user, quiz.lesson.course)
           next_lessson_quiz = Quiz.where(lesson: next_lesson, user: user, grade: nil).first
           expect(QuizWorker).to have_enqueued_job(next_lessson_quiz.id)
        end

        context 'when it is the lesson' do
          let(:quiz) { Quiz.create_quiz(user, lessons[1]) }

          before do
            get :result,
                secret: quiz.secret,
                answers: correct_answers(3)
          end

          it 'sends that the course is finished' do
           expect(CourseFinishedWorker).to have_enqueued_job(quiz.user.id, quiz.lesson.course.id)
          end
        end
      end
    end
  end
end
