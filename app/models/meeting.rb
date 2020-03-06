class Meeting < ApplicationRecord
  belongs_to :team
  belongs_to :room
end
