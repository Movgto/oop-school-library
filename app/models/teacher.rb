require_relative 'person'
require_relative 'data_handler'

class Teacher < Person
  attr_accessor :specialization

  include DataHandler

  def initialize(specialization, age, name = 'Unknown')
    super(age, name, parent_permission: true)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def save
    teacher = {
      'specialization' => @specialization,
      'age' => @age,
      'name' => @name
    }
    save_element(teacher, 'teachers')
  end
end
