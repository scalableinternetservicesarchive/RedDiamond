class CreateThumbs < ActiveRecord::Migration[6.1]
  def change
    create_table :thumbs do |t|
      t.references :thumber, null: false, foreign_key: { to_table: :users }
      t.text :body
      t.references :user, null: false, foreign_key: true
      t.integer :thumbcount
      t.string :thumbable_type

      t.timestamps
    end
    rename_column :thumbs, :user_id, :thumbable_id

    reversible do |dir|
      dir.up { Thumb.update_all("Thumbable_type='User'") }
      dir.down { Thumb.where.not(thumbable_type: 'User').delete_all }
    end
    add_index :thumbs, %i[thumbable_type thumbable_id]
    if foreign_key_exists?(:thumbs, column: :thumbable_id)
      remove_foreign_key :thumbs, column: :thumbable_id
    end
  end
end
