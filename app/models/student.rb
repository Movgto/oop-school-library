require_relative 'person'
require_relative 'data_handler'

class Student < Person
  attr_reader :classroom

  include DataHandler

  def initialize(classroom, age, name = 'Unknown')
    super(age, name, parent_permission: true)
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.student.push(self) unless classroom.student.include?(self)
  end

  def save
    student = {
      'age' => @age,
      'name' => @name
    }
    save_element(student, 'students')
  end
end
