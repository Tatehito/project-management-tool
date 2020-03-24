class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :destroy]

  # 書籍管理画面表示
  def index
    @books = Book.all
  end

  # 書籍追加画面表示
  def new
    @book = Book.new
  end

  # 書籍編集画面表示
  def edit
  end

  # 書籍追加
  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path, notice: '書籍を追加しました。' 
    else
      render :new
    end
  end

  # 書籍編集
  def update
    if @book.update(book_params)
      redirect_to books_path, notice: '書籍情報を更新しました。' 
    else
      render :edit
    end
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
