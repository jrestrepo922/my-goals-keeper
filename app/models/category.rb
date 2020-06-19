class Category < ApplicationRecord
    has_many  :goals 
    has_many :users, through: :goals
    
    validates :name,  uniqueness: true
end
