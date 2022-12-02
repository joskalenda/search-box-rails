class AddArticleRecordColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :article_records, :key_word, :string
    add_column :article_records, :searched_record, :integer
    # add_reference :article_records, :user, index: true, foreign_key: true
    # add_foreign_key :article_records, :users
  end
end