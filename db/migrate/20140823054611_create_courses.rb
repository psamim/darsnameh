class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.text :intro
      t.string :email
      t.timestamps
    end
  end
end
