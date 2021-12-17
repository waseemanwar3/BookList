class CreateBookTag < ActiveRecord::Migration[6.0]
  def change
    create_table :book_tags do |t|
      t.references :book, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
    end
  end
end
