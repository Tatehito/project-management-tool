class RentalBook < ApplicationRecord
  belongs_to :member
  belongs_to :book

  enum status: { open: 0, close: 1 }
end
