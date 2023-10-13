require_relative 'student'
require_relative 'teacher'

class App
  def initialize
    @people = {
      students => [],
      teachers => []
    }
    @books = []
  end

  def list_books
    @books.map { |el| p el.title }
  end

  def list_people
    @people.students.map { |el| p "[Student] Name: #{el.name} ID: #{el.id} Age: #{el.age}" }
    @people.teachers.map { |el| p "[Teacher] Name: #{el.name} ID: #{el.id} Age: #{el.age}" }
  end

  def list_rentals(id)
    search_by_id(id)

    @rentals.each do |rental|
      p "Date: #{rental.date}
      Person: ##{rental.person.name}
      Book: #{rental.book.title}"
    end
  end

  def create_person(type, age, name, specialization = nil)
    case type
    when 1
      student = Student.new(age, name)
      @people.students << student
    when 2
      teacher = Teacher.new(age, specialization, name)
      @people.teachers << teacher
    end
  end

  def search_by_id(id)
    people = []
    @people.each do |_key, value|
      people.concat(value)
    end

    people.find { |el| el.id == id }
  end

  def create_rental(date, id, book_title)
    person = search_by_id(id)

    book = @books.find { |item| item.title == book_title }

    Rental.new(date, book, person)
  end
end
