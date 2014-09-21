class Admin < ActiveRecord::Base
  validates_uniqueness_of :email, :on => :create, :message => "must be unique"
  has_secure_password
end
