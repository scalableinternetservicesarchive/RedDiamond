class IndexGroupDescription < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pg_trgm'

    add_index :groups, :description, using: :gist, opclass: { description: :gist_trgm_ops }
  end
end
