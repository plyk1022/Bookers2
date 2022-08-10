class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to user_path(@book.user.id)
  end

  def show
    @book = Book.new
    @selected_book = Book.find(params[:id])
    @user = @selected_book.user

  end

  def edit
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
