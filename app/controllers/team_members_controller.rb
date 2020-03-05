class TeamMembersController < ApplicationController
  def show
    @team = Team.find(params[:id])
    @new_member = @team.team_members.build
  end

  def create
    team_member = TeamMember.new(team_member_params)
    if team_member.save
      redirect_to action: 'show', id: team_member.team_id
    end
  end

  private

  def team_member_params
    params.require(:team_member).permit(:member_id, :team_id)
  end
end
