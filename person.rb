class Person
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = object_id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def of_age?
    @age >= 18
  end

  def can_use_services?
    @parent_permission || of_age?
  end

  private :of_age?
end

person = Person.new(12, "Diego")
p person.of_age?