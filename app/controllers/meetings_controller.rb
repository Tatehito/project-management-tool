class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.all
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
    @meeting.team = Team.find(params[:id])
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.meeting_members << MeetingMember.new(member_id: @meeting.team.leader.id, meeting_id: @meeting.id, organizer: true)
    if @meeting.save
      redirect_to edit_meeting_path(@meeting), notice: 'Meeting was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    if @meeting.update(meeting_params)
      redirect_to edit_meeting_path, notice: 'Meeting was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.require(:meeting).permit(:team_id, :room_id, :name, :start, :end)
    end
end
