class Genre < ApplicationRecord
    has_many :products
    has_many :withlists, through: :products
end
