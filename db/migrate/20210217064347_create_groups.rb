class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :group_name
      t.string :activity
      t.text :description
      t.string :leader_name
      t.string :game_name
      t.integer :max_member_count
      t.integer :current_member_count

      t.timestamps
    end
  end
end
