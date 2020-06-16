class Wishlist < ApplicationRecord
    has_many :products
    has_many :genres, through: :products
    belongs_to :user
end
