class Course < ActiveRecord::Base
  has_many :lessons
  has_and_belongs_to_many :users
end
