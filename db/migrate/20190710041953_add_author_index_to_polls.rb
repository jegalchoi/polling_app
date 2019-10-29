class AddAuthorIndexToPolls < ActiveRecord::Migration[5.2]
  def change
    add_index :polls, :author_id
  end
end
