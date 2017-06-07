class AddLabelToNotes < ActiveRecord::Migration[5.1]
  def change
    add_reference :notes, :label, foreign_key: true
  end
end
