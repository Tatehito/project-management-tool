class Meeting < ApplicationRecord
  belongs_to :team
  belongs_to :room

  has_many :meeting_members, dependent: :destroy
  has_many :members,   through: :meeting_members

  def organizer
    meeting_members.each do |m|
      return m.member if m.organizer
    end
  end
end
