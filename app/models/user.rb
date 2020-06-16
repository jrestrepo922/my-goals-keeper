class User < ApplicationRecord
    has_one :wishlist
    has_secure_password


    validates :username, :email, :password, presence: true
    validates :username, :email, uniqueness: true
end
