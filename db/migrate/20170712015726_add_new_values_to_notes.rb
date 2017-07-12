class AddNewValuesToNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :description, :text
  end
end
