class AddColoumnToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :visible, :boolean
  end
end
