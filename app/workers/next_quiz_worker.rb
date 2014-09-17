class NextQuizWorker
  include Sidekiq::Worker

  def perform
    Mailer.welcome
  end
end
