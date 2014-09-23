class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :code
      t.boolean :confirmed
      t.timestamps
    end
  end
end
