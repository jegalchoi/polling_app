class AddForeignKeyToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :poll_id, :integer, null:false

    add_index :questions, :poll_id
  end
end
