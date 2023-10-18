require_relative 'data_handler'

class Rental
  attr_accessor :date, :person, :book

  include DataHandler

  def initialize(person, book, date)
    @date = date
    @person = person
    person.rentals << self
    @book = book
    book.rentals << self
  end

  def save(people_list, books_list)
    person_idx = people_list.find_index { |el| el == @person }
    book_idx = books_list.find_index { |el| el == @book }
    rental = {
      'person_idx' => person_idx,
      'book_idx' => book_idx,
      'date' => @date
    }
    save_element(rental, 'rentals')
  end
end
