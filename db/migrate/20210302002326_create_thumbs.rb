class CreateThumbs < ActiveRecord::Migration[6.1]
  def change
    create_table :thumbs do |t|
      t.references :thumber, null: false, foreign_key: { to_table: :users }
      t.references :thumbable, polymorphic: true
      t.integer :value 

      t.timestamps
    end
  end
end
