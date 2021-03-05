class AddApprovalStatusToGroupMemberships < ActiveRecord::Migration[6.1]
  def change
    add_column :group_memberships, :pending, :boolean, default: false
  end
end
