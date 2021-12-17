require 'csv'

desc "Send email to 3 most tagged books"
task :import => [:environment] do

  books = Book.joins(:book_tags).select("books.*, count(book_tags.id) as tcount").group("books.id").order("tcount DESC").limit(3)
  BookMailer.most_tagged_books(books).deliver_now
end