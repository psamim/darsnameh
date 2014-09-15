class Lesson < ActiveRecord::Base
  has_many :questions
  has_many :quiz
  belongs_to :course
  acts_as_list scope: :course
end
