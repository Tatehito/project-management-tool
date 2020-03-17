class LoginController < ApplicationController

  # ログイン画面表示
  def index
    @members = Member.all
    session.delete(:user_id)
  end
end
