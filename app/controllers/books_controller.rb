class BooksController < ApplicationController
  before_action :set_book, except: [:index, :new, :create, :add_tags]

  def index
    @tags = Tag.all
    @books = Book.all
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

  def add_tags
    if params[:book_ids].present?
      params[:book_ids].each do |book_id|
        @book = Book.find(book_id)
        params[:tag_ids].each do |tag_id|
          BookTag.find_or_create_by(book_id: book_id, tag_id: tag_id)
        end
      end
      redirect_to books_path, notice: "Tag/Tags added successfully."
    else
      redirect_to books_path, alert: "Please select books to add tag/tags."
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