class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text
      t.belongs_to :lesson
      t.timestamps
    end
  end
end
