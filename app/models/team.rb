class Team < ApplicationRecord
  has_many :team_members, dependent: :destroy
  has_many :members, through: :team_members
  accepts_nested_attributes_for :team_members, allow_destroy: true

  has_many :meetings, dependent: :destroy

  validates :name, presence: true

  def leader
    TeamMember.find_by(team_id: id, leader: true).member
  end
end
