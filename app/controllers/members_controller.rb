class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # メンバー管理画面表示
  def index
    @members = Member.all
  end

  # メンバートップ画面表示
  def show
    session[:user_id] = @member.id
  end

  # メンバー追加画面表示
  def new
    @member = Member.new
  end

  # メンバー編集画面表示
  def edit
  end

  # メンバー追加
  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to members_path, notice: 'メンバーを追加しました。'
    else
      render :new
    end
  end

  # メンバー更新
  def update
    if @member.update(member_params)
      redirect_to members_path, notice: 'メンバーを更新しました。'
    else
      render :edit
    end
  end

  # メンバー削除
  def destroy
    unless @member.leader?
      @member.destroy
      redirect_to members_url, notice: 'メンバーを削除しました。'
    else
      redirect_to members_url, notice: 'リーダーは削除できません。'
    end
  end

  private
    def set_member
      @member = Member.find(params[:id])
    end

    def member_params
      params.require(:member).permit(:name, :owner)
    end
end
