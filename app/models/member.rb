class Member < ApplicationRecord
  has_many :team_members, dependent: :destroy
  has_many :teams,   through: :team_members

  def leader?(team)
    team.leader == self
  end

  def leader?
    team_members.each do |m|
      return true if m.leader
    end
    false
  end
end
