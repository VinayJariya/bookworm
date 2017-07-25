class BooksController < ApplicationController

	include ApplicationHelper 

	before_action :logged_in_user, only: [:new, :edit, :update, :delete, :custom_books_index]
	before_action :correct_user_for_book, only: [:edit, :update, :delete]
	before_action :correct_user_for_profile, only: [:custom_books_index]

	def new
		@book = Book.new
		@book.user_id = current_user.id
	end

	def index
		@books = Book.all.paginate(page: params[:page])
		@title = "All Books"
	end

	def show
			@books = Book.find_by_id(params[:id])
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			flash[:success] = "Book Succesfully Added !!!"
			redirect_to books_path
		else
			render 'new'
		end
	end

	def edit
		@book = Book.find_by_id(params[:id])
	end

	def update
		@book = Book.find_by_id(params[:id])
		if @book.update_attributes(book_params)
			flash[:success] = "Book updated"
      		redirect_to book_path(@book.id)
      	else
      		render 'edit'
      	end

	end

	def destroy
		@book = Book.find_by_id(params[:id]).destroy
		flash[:success] = "Book deleted"
    	redirect_to books_url
	end

	def custom_books_index
		@books = Book.where( user_id: params[:id]).paginate(page: params[:page])
		@title = User.find_by_id( params[:id]).name
		@header = "My Books" 			
	end

	
	private

		def book_params
			params.require(:book).permit(:name, :author, :description, :donate, :user_id)
		end

		

		

end
