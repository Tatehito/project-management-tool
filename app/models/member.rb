class Member < ApplicationRecord
  has_many :team_members, dependent: :destroy
  has_many :teams,   through: :team_members

  has_many :meeting_members, dependent: :destroy
  has_many :meetings,   through: :meeting_members

  has_many :rental_books, dependent: :destroy
  has_many :books,   through: :rental_books

  def leader?(team=nil)
    if team.nil?
      team_members.each do |m|
        return true if m.leader
      end
      false
    else
      team.leader == self
    end
  end

  def organizer?(meeting)
    meeting.organizer == self
  end

  def books_on_rental
    books.select do |book|
      !book.rentable?
    end
  end
end
