class Team < ApplicationRecord
  has_many :team_members, dependent: :destroy
  has_many :members, through: :team_members
  accepts_nested_attributes_for :team_members, allow_destroy: true

  validates :name, presence: true
end
