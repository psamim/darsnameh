class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.text :text
      t.belongs_to :course
      t.timestamps
    end
  end
end
