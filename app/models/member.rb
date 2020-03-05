class Member < ApplicationRecord
  has_many :team_members, dependent: :destroy
  has_many :teams,   through: :team_members

  def leader?(team)
    team.leader == self
  end
end
