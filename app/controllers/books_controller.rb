class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :destroy]

  # 書籍管理画面表示
  def index
    @books = Book.all
  end

  # 書籍追加画面表示
  def new
  end

  # 書籍編集画面表示
  def edit
  end

  # 書籍追加
  def create
  end

  # 書籍編集
  def update
  end

  # 書籍削除
  def delete
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:name)
    end
end
