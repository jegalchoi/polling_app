class AddAuthorToPolls < ActiveRecord::Migration[5.2]
  def change
    add_column :polls, :author_id, :integer, null:false
  end
end
