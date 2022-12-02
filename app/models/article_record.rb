class ArticleRecord < ApplicationRecord
  # scope :highest_record, -> (searched_record) where()
  scope :filtered_record, -> (key_word) {where('key_word ILIKE ?', "%#{key_word}%")}
end
