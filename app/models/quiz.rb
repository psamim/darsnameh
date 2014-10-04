class Quiz < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson

  def to_param
    secret
  end

  def self.create_quiz(user, lesson)
    quiz = Quiz.create(
                       user: user,
                       lesson: lesson,
                       secret: generate_secret(user),
                       expire: 2.day.from_now)
    quiz
  end

  def self.generate_secret(user)
    Digest::SHA1.hexdigest Time.new.to_f.to_s + user.id.to_s
  end
end
