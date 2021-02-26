class RemoveCommentFkConstraint < ActiveRecord::Migration[6.1]
  def change
    if foreign_key_exists?(:comments, column: :commentable_id)
      remove_foreign_key :comments, column: :commentable_id
    end
  end
end
