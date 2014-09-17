class Course < ActiveRecord::Base
  has_many :lessons
  has_many :users, through: :enrollments
  has_many :enrollments
  validates_presence_of :email, :title
end
