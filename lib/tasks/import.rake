require 'csv'

desc "Import books from csv file"
task :import => [:environment] do

  file = 'public/books.csv'
  books_array = []

  CSV.foreach(file, :headers => true) do |row|
    books_array << {
      title: row["title"],
      description: row["descrption"],
      price: row["price"].to_f
    }
  end
  Book.create(books_array)
end