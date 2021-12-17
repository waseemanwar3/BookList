class BookMailer < ActionMailer::Base
  def most_tagged_books(books)
    @books = books
    mail(to: "default@emial.com", subject: "Most tagged books")
  end
end