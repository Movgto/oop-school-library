require './app/models/student'
require './app/models/teacher'
require './app/models/book'
require './app/models/rental'

module Library
  def wrong_number_msg
    puts "\n*** [WARNING] You passed a wrong number ***\n\n"
  end

  def valid_number?(range, choice)
    return true if range.include?(choice)

    wrong_number_msg

    false
  end

  def success_msg(label)
    puts "\n#{label} Created successfully\n\n"
  end

  def get_list_books(data, show_index = false)
    puts "\nAll Books:"
    data[:books].any? ? display_books(data[:books], show_index) : puts('No record found')
    puts "\n"
  end

  def get_list_people(data, show_index = false)
    puts "\nAll People:"
    data[:people].any? ? display_people(data[:people], show_index) : puts('No record found')
    puts "\n"
  end

  def display_books(books, show_index)
    books.each.with_index do |book, index|
      book_index = show_index ? "#{index})" : ''
      puts "#{book_index} Title: #{book.title}, Author: #{book.author}"
    end
  end

  def display_people(people, show_index)
    people.each.with_index do |person, index|
      person_index = show_index ? "#{index})" : ''
      puts "#{person_index} #{person.description}"
    end
  end

  def select_person(data)
    puts 'Select a person from the following list by number (not id)'
    get_list_people(data, true)
    gets.chomp.to_i
  end

  def add_new_person(*)
    puts 'Do you want to create a student (1) or a teacher (2) [Input the number]:'
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
  end

  def create_student(age, name)
    student = Student.new(nil, age, name)
    puts 'Has Parent Permission? [Y/N]:'
    par_permission = gets.chomp
    student.parent_permission = (par_permission.upcase == 'Y')
    student.save
    puts JSON.generate(student)
    success_msg('Person')
  end

  def create_teacher(age, name)
    teacher = Teacher.new(nil, age, name)
    puts 'Specialization:'
    teacher.specialization = gets.chomp
    teacher.save
    success_msg('Person')
  end

  def add_new_book
    book = Book.new(nil, nil)
    puts 'Title:'
    book.title = gets.chomp
    puts 'Author:'
    book.author = gets.chomp
    book.save
    success_msg('Book')
  end

  def create_new_rental(data)
    puts 'Select a book from the following list by number'
    get_list_books(data, true)
    book_index = gets.chomp
    person_index = select_person(data)

    if data[:people][person_index] && data[:books][book_index]
      rental = Rental.new(data[:people][person_index], data[:books][book_index], nil)
      puts 'Date:'
      rental_date = gets.chomp
      rental.date = rental_date
      success_msg('Rental')
      rental.save(data[:people], data[:books])
    else
      wrong_number_msg
    end
  end

  def exit
    false
  end
end
