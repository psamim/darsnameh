class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.belongs_to :user
      t.belongs_to :lesson
      t.integer :grade
      t.string :secret
      t.datetime :expire
      t.timestamps
    end
  end
end
