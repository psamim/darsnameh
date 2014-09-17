class CreateAdminUser < ActiveRecord::Migration
  def change
    create_table :admin_users do |t|
      a = User.new
      a.email = "admin"
      a.password = "adminadmin"
      a.save
    end
  end
end
