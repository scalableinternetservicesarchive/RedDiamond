class AddOwnerToGroupMemberships < ActiveRecord::Migration[6.1]
  def change
    add_column :group_memberships, :owner, :boolean, null: false, default: false
  end
end
