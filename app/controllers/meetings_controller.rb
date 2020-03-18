class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

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
      redirect_to edit_meeting_path(@meeting), notice: 'Meeting was successfully created.'
    else
      render :new
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
    if @meeting.update(meeting_params)
      redirect_to edit_meeting_path, notice: 'Meeting was successfully updated.'
    else
      render :edit
    end
  end

  # ミーティング参加メンバー削除
  def destroy_member
  end

  # ミーティング幹事変更
  def change_organizer
    @meeting.meeting_members = @meeting.update_organizer(params[:id])
    if @meeting.update(meeting_params)
      redirect_to edit_meeting_path, notice: '幹事を変更しました。'
    else
      render :edit
    end
  end

  private
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    def meeting_params
      params.require(:meeting).permit(:team_id, :room_id, :name, :start, :end)
    end
end
