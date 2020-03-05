class TeamMembersController < ApplicationController
  before_action :set_team_member, only: [:destroy]

  def show
    @team = Team.find(params[:id])
    @new_member = @team.team_members.build
  end

  def create
    new_member = TeamMember.new(team_member_params)
    if new_member.save
      redirect_to action: 'show', id: new_member.team_id
    end
  end

  def destroy
    @team_member.destroy
    redirect_to action: 'show', id: @team_member.team_id
  end

  private

  def set_team_member
    @team_member = TeamMember.find(params[:id])
  end

  def team_member_params
    params.require(:team_member).permit(:member_id, :team_id)
  end
end
