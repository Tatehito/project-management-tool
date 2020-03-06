class Room < ApplicationRecord
  has_many :meetings, dependent: :destroy
end
