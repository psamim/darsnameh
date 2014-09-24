class Quiz < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson

  def to_param
    secret
  end
end
