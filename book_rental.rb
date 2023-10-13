class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(date, person)
    Rental.new(date, self, person)
  end
end

class Rental
  attr_accessor :date
  attr_reader :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    book.rentals << self
    @person = person
    person.rentals << self
  end
end
