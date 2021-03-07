class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @book = Book.new
    @books = Book.all
    @book.user_id = current_user.id
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
   if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
   else
     @books = Book.all
     render :index
   end
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id = current_user.id
      render :edit
    else
      redirect_to book_path
    end
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    flash[:notice] = "You have update book successfully."
    redirect_to book_path(book.id)
  end

  def destroy
   book = Book.find(params[:id])
   book.destroy
   redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end