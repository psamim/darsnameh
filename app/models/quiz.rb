class Quiz < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
end
