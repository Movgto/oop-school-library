require_relative 'person'
require 'json'

class Teacher < Person
  attr_accessor :specialization

  def initialize(specialization, age, name = 'Unknown')
    super(age, name, parent_permission: true)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def save
    teacher = {
      "specialization" => @specialization,
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

    if File.exist?('./data/teachers.json') 
      teachers = JSON.parse(
        File
        .open('./data/teachers.json')
        .read
      )

      teachers.push(teacher)

      File.write('./data/teachers.json', JSON.generate(teachers, opts))

      p "Teachers", teachers

    else
      File.write('./data/teachers.json', JSON.generate([teacher], opts))
    end
  end
end
