class AddArticleRecordColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :article_records, :key_word, :string
    add_column :article_records, :searched_record, :integer
  end
end
