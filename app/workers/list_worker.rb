class ListWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find user_id
    Mailer.send_all_courses(user).deliver
  end
end
