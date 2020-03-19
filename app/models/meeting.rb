class Meeting < ApplicationRecord
  belongs_to :team
  belongs_to :room

  has_many :meeting_members, dependent: :destroy
  has_many :members,   through: :meeting_members

  validate :date_reversal
  validate :reserved

  def date_reversal
    if start_time > end_time
      errors.add(:base, '開始時間と終了時間が逆転しています。')
    end
  end

  def reserved
    room.meetings.each do |m|
      if (start_time <= m.start_time && end_time >= m.start_time) ||
         (start_time >= m.start_time && start_time <= m.end_time)
        errors.add(:base, "会議室「#{room.name}」は予約済みです。時間を変更してください。")
        break
      end
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
