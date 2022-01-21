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

  def self.search(query, title_only: false, book_format_type_id: nil, book_format_physical: nil)
    # Todo: complete logic for keyword arguments
    q = where('LOWER(title) LIKE ?', "%#{query.downcase}%")
    return q if title_only

    q.or(where(author: authors(query))).or(where(publisher: publishers(query))).distinct
  end

  def self.authors(query)
    Author.where('LOWER(last_name) = ?', query.downcase)
  end

  def self.publishers(query)
    Publisher.where('LOWER(name) = ?', query.downcase)
  end

end
