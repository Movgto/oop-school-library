require_relative 'student'
require_relative 'teacher'

class App
  def initialize
    @people = {
      students = [],
      teachers = []
    }
    @books = []
  end

  def list_books
    @books.map {|el| p el.title}
  end

  def list_people
    @people.students.map {|el| p "[Student] Name: #{el.name} ID: #{el.id} Age: #{el.age}"}
    @people.teachers.map {|el| p "[Teacher] Name: #{el.name} ID: #{el.id} Age: #{el.age}"}
  end

  def create_person(type, age, name, specialization = nil)
    case type
    when 1
      student = Student.new(age, name)
      @people.students << student
    when 2
      teacher = Teacher.new(age, specialization, name)
      @people.teachers << teacher
    else
      return
    end
  end

  def search_by_id(id)
    people = []
    @people.each do |key, value|
      people.concat(value)
    end

    person = people.find {|el| el.id === id}
    person
  end

  def create_rental(date, id, book_title)
    person = search_by_id(id)

    book = @books.find {|book| book.title === book_title}

    rental = Rental.new(date, book, person)
  end

  def list_rentals(id)
    person = search_by_id(id)

    @rentals.each do |rental|
      p "Date: #{rental.date}
      Person: ##{rental.person.name}
      Book: #{rental.book.title}"
    end
  end
end