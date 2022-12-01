class Addnewtablestocahe < ActiveRecord::Migration[7.0]
  def change
    add_column :caches, :title, :string
    add_column :caches, :user_id, :integer
    # add_index :caches, :user_id
    # add_column :caches, :timestamps
  end
end
