class Meeting < ApplicationRecord
  belongs_to :team
  belongs_to :room

  has_many :meeting_members, dependent: :destroy
  has_many :members,   through: :meeting_members

  validate :check_capacity

    def check_capacity
      if members.size > room.capacity
        errors.add(:capacity, "会議室「#{room.name}」の定員オーバーです.")
      end
    end

  def organizer
    meeting_members.each do |m|
      return m.member if m.organizer
    end
  end

  def outside_members
    team.members.where.not(id: meeting_members.select("member_id"))
  end
end
