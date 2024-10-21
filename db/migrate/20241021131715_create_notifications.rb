class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.integer :task_id
      t.text :extracted_data
      t.integer :user_id

      t.timestamps
    end
  end
end
