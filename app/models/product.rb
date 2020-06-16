class Product < ApplicationRecord
    belongs_to :genre
    belongs_to :wishlist
end
