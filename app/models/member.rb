class Member < ApplicationRecord
  has_many :team_members, dependent: :destroy
  has_many :teams,   through: :team_members

  has_many :meeting_members, dependent: :destroy
  has_many :meetings,   through: :meeting_members
end
