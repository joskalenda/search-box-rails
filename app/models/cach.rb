class Cach < ApplicationRecord
    validates :title, presence: true, uniqueness: true
end
