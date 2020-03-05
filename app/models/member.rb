class Member < ApplicationRecord
  has_many :teams,   through: :team_members
  has_many :team_members, dependent: :destroy
end
