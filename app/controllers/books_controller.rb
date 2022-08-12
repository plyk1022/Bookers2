class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :specified_user, only: [:edit]
  
  def specified_user
    @user = Book.find(params[:id]).user
    redirect_to books_path unless @user.id == current_user.id
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end
  
  def create
    @book = Book.new(book_params)
    @books = Book.all
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def show
    @book = Book.new
    @selected_book = Book.find(params[:id])
    @user = @selected_book.user

  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:notice] = "You have updated book successfully."
    else
      render :edit
    end
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
