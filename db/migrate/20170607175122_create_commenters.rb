class CreateCommenters < ActiveRecord::Migration[5.1]
  def change
    create_table :commenters do |t|
      t.text :message

      t.timestamps
    end
  end
end
