class NextQuizWorker
  include Sidekiq::Worker

  def perform(quiz_id)
    quiz = Quiz.find quiz_id
    Mailer.send_quiz(quiz).deliver
  end
end
