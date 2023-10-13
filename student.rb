require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'classroom'

class Student < Person
  attr_accessor :classroom

  def initialize(age, name = 'Unknown', classroom = nil, parent_permission = true)
    super(age, name, parent_permission)
    return unless classroom

    @classroom = classroom
    classroom.add_student(self)
  end

  def assign_classroom(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end

classroom = Classroom.new(301)
student = Student.new(13, classroom, 'Mario')
book_dune = Book.new('Dune', 'Frank Herbert')
rental = Rental.new('2023-10-21', book_dune, student)

p student.rentals[0].date
p book_dune.rentals[0].date
p rental.book.author
p rental.person.name
