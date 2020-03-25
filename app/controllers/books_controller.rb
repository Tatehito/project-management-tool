class BooksController < ApplicationController
  require 'date'
  before_action :set_book, only: [:edit, :update, :destroy, :rental_book, :return]

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

  # 書籍レンタル画面表示
  def rental
    @books = Book.rentable_books
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
  def destroy
    @book.destroy
    redirect_to books_path, notice: '書籍を削除しました。' 
  end

  # 書籍レンタル
  def rental_book
    checkout_date = Date.today
    return_date = checkout_date + 7

    @book.rental_books.new(
      member_id: current_user.id,
      checkout_date: checkout_date,
      return_date: return_date,
      status: :close)
    if @book.save
      redirect_to rental_books_path, notice: "書籍をレンタルしました。返却日は#{ return_date }です。"
    end
  end

  # 書籍返却
  def return
    @book.rental_books.find_by(member_id: current_user.id).destroy
    redirect_to current_user, notice: "書籍を返却しました。"
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:name)
    end
end
