require_relative 'data_handler'

class Book
  attr_accessor :title, :author, :rentals

  include DataHandler

  def initialize(title, author)
    @id = Random.rand(1..10_000)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(rental)
    @rentals.push(rental)
  end

  def save
    book = {
      'title' => @title,
      'author' => @author
    }
    save_element(book, 'books')
  end
end
