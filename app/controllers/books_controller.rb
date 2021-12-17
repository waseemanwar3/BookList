class BooksController < ApplicationController
  before_action :set_book, except: [:index, :new, :create]

  def index
    @books = Book.all.order(created_at: :desc)
    @books = @books.by_name(params[:search]) if params[:search].present?
    @books = @books.by_price(params[:price].to_f) if params[:price].present?
    @books = @books.by_tag_name(params[:tag]) if params[:tag].present?
  end

  def new
    @book = Book.new
    @tags = Tag.all
  end

  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "Book created successfully"}
        format.json { render json: @book, status: :updated }
      else
        format.html { render :edit, alert: @book.errors.full_messages.to_sentence }
        format.json { render json: @book.errors, status: :updated }
      end
    end
  end

  def show; end

  def edit
    @tags = Tag.all
  end

  def update
    @book.assign_attributes(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "Book updated successfully."}
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
    params.require(:book).permit(:title, :description, :price, tag_ids: [])
  end
end