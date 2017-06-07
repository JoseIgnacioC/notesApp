class AddNoteToCommenters < ActiveRecord::Migration[5.1]
  def change
    add_reference :commenters, :note, foreign_key: true
  end
end
