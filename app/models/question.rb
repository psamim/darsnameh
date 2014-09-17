class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :lesson
  accepts_nested_attributes_for :answers
  validates_presence_of :text
end
