class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.integer :gender
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.timestamps
    end
  end
end
