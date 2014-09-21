class StatusWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find user_id
    Mailer.send_status user
  end
end
