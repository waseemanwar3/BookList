class Book < ApplicationRecord
  serialize :tags, Array

  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags

  scope :by_name, -> (name) { where('title LIKE ?', "%#{name}%") }
  scope :by_price, -> (price) { where('price = ?', price) }
  scope :by_tag_name, -> (tag) { joins(:tags).where('name LIKE ?', "%#{tag}%") }

  def tag(id)
    Tag.find(id).name
  end
end