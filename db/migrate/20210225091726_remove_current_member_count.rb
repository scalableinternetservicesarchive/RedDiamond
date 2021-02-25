class RemoveCurrentMemberCount < ActiveRecord::Migration[6.1]
  def change
    remove_column :groups, :current_member_count, :integer
  end
end
