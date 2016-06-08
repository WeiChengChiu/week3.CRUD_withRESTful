class BooksController < ApplicationController

  before_action :set_book, :only => [ :show, :edit, :update, :destroy]

  def index
  	@books = Book.page( params[:page] ).per(5)
  end

  def new
  	@book = Book.new
  end	

  def create
  	@book = Book.new(book_params)
  	if @book.save
     flash[:notice] = "book was successfully created"
  	 redirect_to books_path


    else
      render new_book_path
    end
  end

  def show
    @page_title = @book.name
  end	
  
  def edit
  end

  def update
  	if @book.update(book_params)
      flash[:notice] = "book was successsfully update"
  	  redirect_to book_path(@book)    
    else
      render :edit
    end
  end

  def destroy
  	@book.destroy
    flash[:alert] = "book was successsfully deleted"
  	redirect_to books_path
  end


  private

  def book_params
  	params.require(:book).permit(:name, :description)
  end	

  def set_book
    @book = Book.find(params[:id])
  end

end
