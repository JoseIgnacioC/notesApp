class AddUserToLabels < ActiveRecord::Migration[5.1]
  def change
    add_reference :labels, :user, foreign_key: true
  end
end
