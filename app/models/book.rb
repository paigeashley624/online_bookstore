class Book < ApplicationRecord
  belongs_to :publisher
  belongs_to :author
  has_many :book_formats, dependent: :destroy
  has_many :book_formats_types, through: :book_formats
  has_many :book_reviews
  validates :title, presence: true
  
  def author_name
    [author.last_name, author.first_name].compact.join(', ')
  end 
  
  def average_rating
    book_reviews.average(:rating).to_i.round(1)
  end

  def self.search(query)
    
    authors = Author.where('LOWER(last_name) = ?', query.downcase)
    publishers = Publisher.where('LOWER(name) = ?',query.downcase)
    where(author: authors).or(
      where(publisher: publishers)).or(
      where('LOWER(title) LIKE ?', "%#{query.downcase}%"))

    
  end
  
end
