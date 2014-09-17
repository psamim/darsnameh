class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :text
      t.integer :position
      t.belongs_to :course
      t.timestamps
    end
  end
end
