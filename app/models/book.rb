class Book < ApplicationRecord
  belongs_to :publisher
  belongs_to :author
  has_many :book_formats
  has_many :book_formats_types, through: :book_formats
  has_many :book_reviews
  

end
