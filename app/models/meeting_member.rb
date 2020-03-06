class MeetingMember < ApplicationRecord
  belongs_to :member
  belongs_to :meeting
end
