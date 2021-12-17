class BooksController < ApplicationController
  before_action :set_book, except: [:index]

  def index
    @books = Book.all.order(created_at: :desc)
    @books = @books.by_name(params[:search]) if params[:search].present?
    @books = @books.by_price(params[:price].to_f) if params[:price].present?
  end

  def show
  end

  def edit
    @tags = Tag.all
  end

  def update
    @book.assign_attributes(book_params)
    @book.tags = book_params[:tags].reject { |t| t.empty? }
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "Tag assigned to book successfully."}
        format.json { render json: @book, status: :updated }
      else
        format.html { render :edit, alert: @book.errors.full_messages.to_sentence }
        format.json { render json: @book.errors, status: :updated }
      end
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :description, tags: [])
  end
end