require_relative 'student'
require_relative 'teacher'
require_relative 'book'

class App
  attr_reader :books, :people
  def initialize
    @people = {
      "students" => [],
      "teachers" => []
    }
    @books = []
  end

  def list_books
    @books.each_with_index { |el, i| print " #{i}. Title: #{el.title} Author: #{el.author}\n" }
  end

  def list_people
    @people["students"].each { |el| print "[Student] Name: #{el.name} ID: #{el.id} Age: #{el.age}\n" }
    @people["teachers"].each { |el| print "[Teacher] Name: #{el.name} ID: #{el.id} Age: #{el.age}\n" }
  end

  def list_rentals(person)
    person.rentals.each do |rental|
      print "Date: #{rental.date} Book: #{rental.book.title}\n"
    end
  end

  def create_person(type, age, name, specialization = nil)
    case type
    when 1
      student = Student.new(age, name)
      @people["students"] << student
    when 2
      teacher = Teacher.new(age, specialization, name)
      @people["teachers"] << teacher
    end
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books << book
  end

  def search_by_id(id)
    people = []
    @people.each do |key, value|
      people.concat(value)
    end
    p people
    return people.find { |el| el.id == id }
  end

  def create_rental(date, person, book)
    Rental.new(date, book, person)
  end

  def people_exist?
    @people.each do |key, value|
      if value.length > 0
        return true
      end
    end
    false
  end
end
