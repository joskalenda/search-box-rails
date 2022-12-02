class CreateArticleRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :article_records do |t|

      t.timestamps
    end
  end
end
