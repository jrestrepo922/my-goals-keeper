class User < ApplicationRecord
    has_many  :goals 
    has_many :categories, through: :goals
    
    has_secure_password
    
    validates :username, :email, :password, :password_confirmation, presence: true
    validates :username, :email, uniqueness: true
end
