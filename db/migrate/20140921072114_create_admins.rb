class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :email
      t.string :password_digest
      t.timestamps
      t.timestamps
    end

    admin = Admin.new
    admin.email = "admin"
    admin.password = "adminadmin"
    admin.save
  end
end
