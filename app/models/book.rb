class Book < ApplicationRecord
  serialize :tags, Array

  scope :by_name, -> (name) { where('title LIKE ?', "%#{name}%") }
  scope :by_price, -> (price) { where('price = ?', price) }

  def tag(id)
    Tag.find(id).name
  end
end