class Lesson < ActiveRecord::Base
  has_many :questions
  belongs_to :course
  acts_as_list scope: :course
end
