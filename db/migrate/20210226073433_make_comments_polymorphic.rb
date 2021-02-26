class MakeCommentsPolymorphic < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :user_id, :commentable_id
    add_column :comments, :commentable_type, :string
    reversible do |dir|
      dir.up { Comment.update_all("commentable_type='User'") }
      dir.down { Comment.where.not(commentable_type: 'User').delete_all }
    end
    add_index :comments, %i[commentable_type commentable_id]
  end
end
