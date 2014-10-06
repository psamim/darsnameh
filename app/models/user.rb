class User < ActiveRecord::Base
  has_many :courses, through: :enrollments
  has_many :enrollments
  has_many :quiz
  validates_uniqueness_of :email, on: :create, message: 'must be unique'
  validates_email_format_of :email, message: 'is not looking good'
end
