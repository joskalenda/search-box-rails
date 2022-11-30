class Article < ApplicationRecord
  scope :filtered_title, -> (title) {where('title ILIKE ?', "%#{title}%")}
end
