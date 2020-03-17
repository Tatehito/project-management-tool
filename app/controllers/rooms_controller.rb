class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # 会議室管理画面表示
  def index
    @rooms = Room.all
  end

  # 会議室追加画面表示
  def new
    @room = Room.new
  end

  # 会議室編集画面表示
  def edit
  end

  # 会議室追加
  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to rooms_path, notice: 'Room was successfully created.'
    else
      render :new
    end
  end

  # 会議室編集
  def update
    if @room.update(room_params)
      redirect_to rooms_path, notice: 'Room was successfully updated.'
    else
      render :edit
    end
  end

  # 会議室廃止
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name, :capacity)
    end
end
