class CreateCaches < ActiveRecord::Migration[7.0]
  def change
    create_table :caches do |t|

      t.timestamps
    end
  end
end
