class Course < ActiveRecord::Base
  has_many :lessons
end
