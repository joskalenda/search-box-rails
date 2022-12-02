class Article < ApplicationRecord
  scope :filtered_title, -> (title) {where('title ILIKE ?', "%#{title}%")}

  has_many :article_records
  validates :title, presence: true,  uniqueness: true
end
