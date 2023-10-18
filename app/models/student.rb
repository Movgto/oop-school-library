require_relative 'person'

class Student < Person
  attr_reader :classroom

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
      "age" => @age,
      "name" => @name,
    }

    opts = {
      array_nl: "\n",
      object_nl: "\n",
      indent: '  ',
      space_before: ' ',
      space: ' '
    }

    if File.exist?('./data/students.json') 
      students = JSON.parse(
        File
        .open('./data/students.json')
        .read
      )

      students.push(student)

      File.write('./data/students.json', JSON.generate(students, opts))

      p "Students ", students

    else
      File.write('./data/students.json', JSON.generate([student], opts))
    end
  end
end
