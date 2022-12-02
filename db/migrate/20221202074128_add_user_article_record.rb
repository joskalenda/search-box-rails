class AddUserArticleRecord < ActiveRecord::Migration[7.0]
  def change
    add_reference :article_records, :user, index: true, foreign_key: true
    # add_foreign_key :article_records, :users
  end
end
