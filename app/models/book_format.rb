class BookFormat < ApplicationRecord

  # A many-to-many relationship model between Books and their Formats

  belongs_to :book 
  belongs_to :book_format_type
  
end
