class AddReferencesToTeamMember < ActiveRecord::Migration[6.0]
  def change
    add_reference :team_members, :team, foreign_key: true
    add_reference :team_members, :member, foreign_key: true
  end
end
