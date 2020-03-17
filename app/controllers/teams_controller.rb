class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :members]

  # チーム一覧画面表示
  def index
    @teams = Team.all
  end

  # チームトップ画面表示
  def show
  end

  # チーム追加画面表示
  def new
    @team = Team.new
    @team.team_members.build
  end

  # チーム編集画面表示
  def edit
  end

  # チームメンバー管理画面表示
  def members
    @new_member = @team.team_members.build
  end

  # チーム追加
  def create
    @team = Team.new(team_params)
    @team.team_members.first.leader = true;
    if @team.save
      redirect_to teams_path, notice: 'チームを作成しました。'
    else
      render :new
    end
  end

  # チーム名・リーダー変更
  def update
    new_leader_id = params[:team][:leader_id]
    @team.name = params[:team][:name]
    @team.team_members = @team.update_leader(new_leader_id)
    unless @team.exists_leader?
      @team.team_members.new(member_id: new_leader_id, leader: true)
    end
    
    if @team.save
      redirect_to teams_path, notice: 'Team was successfully updated.'
    else
      render :edit
    end
  end

  # チーム削除
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # チームメンバー追加
  def add_member
    @team.team_member << TeamMember.new(team_member_params)
    if @team.save
      redirect_to action: 'show', id: new_member.team_id
    end
  end

  # チームメンバー削除
  def destroy_member
    @team_member.destroy
    redirect_to action: 'show', id: @team_member.team_id
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name, team_members_attributes: [:id, :member_id, :team_id, :leader])
    end
end
