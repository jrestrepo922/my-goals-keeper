class Goal < ApplicationRecord
    scope :completed_goals, -> {where(completed: true)}

    belongs_to :user
    belongs_to :category
    accepts_nested_attributes_for :category, reject_if: :all_blank

    validates :name, :details, presence: true
end
