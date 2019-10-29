class AddForeignKeyToAnswerChoices < ActiveRecord::Migration[5.2]
  def change
    add_column :answer_choices, :question_id, :integer, null: false

    add_index :answer_choices, :question_id
  end
end
