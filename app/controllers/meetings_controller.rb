class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy, :add_member, :destroy_member]

  # ミーティング追加画面表示
  def new
    @meeting = Meeting.new(team_id: params[:team_id])
  end

  # ミーティング参照/編集画面表示
  def edit
  end

  # ミーティング追加
  # 幹事はチームリーダーが自動的にセットされる
  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.meeting_members << MeetingMember.new(member_id: @meeting.team.leader.id, meeting_id: @meeting.id, organizer: true)
    if @meeting.save
      redirect_to edit_team_meeting_path(id: @meeting.id), notice: 'ミーティングを追加しました。'
    else
      render :new
    end
  end

  # ミーティング編集
  def update
    if @meeting.update(meeting_params)
      redirect_to edit_team_meeting_path, notice: 'ミーティングを編集しました。'
    else 
      redirect_to edit_team_meeting_path, notice: 'ミーティングの編集に失敗しました。'
    end
  end

  # ミーティングキャンセル
  def destroy
    @meeting.destroy
    redirect_to @meeting.team, notice: 'Meeting was successfully destroyed.'
  end

  # ミーティング参加メンバー追加
  def add_member
    new_member_id = params[:new_member][:id]
    @meeting.members << Member.find(new_member_id) if new_member_id.present?
    if @meeting.save
      redirect_to edit_team_meeting_path, notice: '参加メンバーを追加しました。'
    else
      render :edit
    end
  end

  # ミーティング参加メンバー削除
  def destroy_member
    @member = @meeting.meeting_members.find_by(member_id: params[:member_id])
    @member.destroy
    redirect_to edit_team_meeting_path, notice: '参加メンバーを削除しました。'
  end

  # ミーティング幹事変更
  def change_organizer
    meeting_members = MeetingMember.where(meeting_id: params[:id])
    old_organizer = meeting_members.find_by(organizer: true)
    new_organizer = meeting_members.find_by(member_id: params[:member_id])
    ActiveRecord::Base.transaction do
      old_organizer.update_attributes!(organizer: false)
      new_organizer.update_attributes!(organizer: true)
    end
    redirect_to edit_team_meeting_path, notice: '幹事を変更しました。'
  end

  private
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    def meeting_params
      params.require(:meeting).permit(:team_id, :room_id, :name, :start, :end)
    end
end
