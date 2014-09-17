class User < ActiveRecord::Base
  has_many :courses, through: :enrollments
  has_many :enrollments
  has_many :quiz
  validates_uniqueness_of :email, :on => :create, :message => "must be unique"
  has_secure_password
end
