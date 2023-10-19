require './app/models/student'
require './app/models/teacher'
require './app/models/book'
require './app/models/rental'
module Library
  def wrong_number_msg
    puts "\n*** [WARNING] You passed a wrong number ***"
    puts "\n"
  end

  def valid_number?(range, choice)
    unless range.include?(choice)
      wrong_number_msg
      return false
    end
    true
  end

  def success_msg(label)
    puts "\n#{label} Created successfully"
    puts "\n"
  end

  def get_list_books(data, show_index = false)
    puts "\nAll Books:"
    if data[:books].length.positive?
      data[:books].each.with_index do |book, index|
        book_index = show_index ? "#{index})" : ''
        puts "#{book_index} Title: #{book.title},  Author: #{book.author}"
      end
    else
      puts 'No record found'
    end
    puts "\n"
  end

  def get_list_person(data, show_index = false)
    puts "\nAll People:"
    if data[:people].length.positive?
      data[:people].each.with_index do |people, index|
        person_index = show_index ? "#{index})" : ''
        puts "#{person_index} #{people.description}"
      end
    else
      puts 'No record found'
    end
    puts "\n"
  end

  def get_user_rental(data)
    puts 'All rentals for a given person number(not id)'
    get_list_person(data, true)
    idx = gets.chomp
    data[:people][idx.to_i].rentals_description
    puts "\n"
  end

  def add_new_person()
    puts 'Do you want to create a student (1) or a teacher (2) [Input the number] :'
    choice = gets.chomp

    return unless valid_number?(%w[1 2], choice)

    puts 'Age:'
    age = gets.chomp
    puts 'Name:'
    name = gets.chomp
    case choice
    when '1'
      create_student(age, name)
    when '2'
      create_teacher(age, name)
    end

    success_msg('Person')
  end

  def create_student(age, name)
    student = Student.new(nil, age, name)
    puts 'Has Parent Permission? [Y/N]:'
    par_permission = gets.chomp
    student.parent_permission = (par_permission.upcase == 'Y')
    student.save
    p JSON.generate(student)
  end

  def create_teacher(age, name)
    teacher = Teacher.new(nil, age, name)
    puts 'Specialization:'
    teacher.specialization = gets.chomp
    teacher.save
  end

  def create_new_rental(data)
    puts 'Select a book from the following list by number'
    get_list_books(data, true)
    book_index = gets.chomp
    puts 'Select a person from the following list by number (not id)'
    get_list_person(data, true)
    person_index = gets.chomp

    if !data[:people][person_index.to_i].nil? && !data[:books][book_index.to_i].nil?
      rental = Rental.new(data[:people][person_index.to_i], data[:books][book_index.to_i], nil)
      puts 'Date:'
      rental_date = gets.chomp
      rental.date = rental_date
      success_msg('Rental')
      rental.save(data[:people], data[:books])
    else
      wrong_number_msg
    end
  end

  def exit(*)
    false
  end
end

# Create a new module for book-related actions
module BookActions
  def add_new_book(*)
    book = Book.new(nil, nil)
    puts 'title:'
    book.title = gets.chomp
    puts 'Author:'
    book.author = gets.chomp
    book.save
    success_msg('Book')
  end
end

# Include the BookActions module
include BookActions
