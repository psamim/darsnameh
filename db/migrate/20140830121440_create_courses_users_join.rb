class CreateCoursesUsersJoin < ActiveRecord::Migration
  def change
    create_table :courses_users, :id => false do |t|
      t.integer :user_id
      t.integer :course_id
    end
    add_index :courses_users, ["user_id", "course_id"]
  end
end
