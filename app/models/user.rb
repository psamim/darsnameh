class User < ActiveRecord::Base
  has_and_belongs_to_many :courses
  validates_uniqueness_of :email, :on => :create, :message => "must be unique"
  has_secure_password
end
