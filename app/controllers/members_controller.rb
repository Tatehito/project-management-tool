class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def login
    @members = Member.all
    # 疑似ログアウト
    session.delete(:user_id)
  end

  # GET /members
  # GET /members.json
  def index
    @members = Member.all
  end

  # GET /members/1
  # GET /members/1.json
  def show
    # 疑似ログイン
    session[:user_id] = @member.id
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to members_path, notice: 'Member was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    if @member.update(member_params)
      redirect_to members_path, notice: 'Member was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    unless @member.leader?
      @member.destroy
      redirect_to members_url, notice: 'Member was successfully destroyed.'
    else
      redirect_to members_url, notice: 'リーダーは削除できません.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:name, :owner)
    end
end
