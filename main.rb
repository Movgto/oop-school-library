require_relative 'app'

def book_list(app)
  print "Book list:\n"
  if app.books.length.positive?
    app.list_books
    print 'Press enter to continue'
  else
    print 'There are not any books added yet'
  end
  gets.chomp
end

def people_list(app)
  if app.people_exist?
    app.list_people
    print "\nPress enter to continue\n"
  else
    print "There are not any people added yet\n"
    print "Press enter to continue\n"
  end
  gets.chomp
end

def create_student(app, type)
  print 'Age: '
  age = gets.chomp
  print 'Name: '
  name = gets.chomp
  age = age.to_i # Convert age from string to integer
  app.create_person(type, age, name)
  print 'Person created successfully(press enter)'
  gets.chomp
end

def create_teacher(app, type)
  print 'Age: '
  age = gets.chomp
  age = age.to_i
  print 'Name: '
  name = gets.chomp
  print 'Specialization: '
  specialization = gets.chomp
  app.create_person(type, age, name, specialization)
  print "Person '#{name}' created succesfully(press enter)"
  gets.chomp
end

def create_person(app)
  print "What type of person would you like to create?\n"
  print "1. Student\n2. Teacher\n"
  print "Type(enter option number): \n"
  type = gets.chomp
  type = type.to_i
  case type
  when 1
    create_student(app, type)
  when 2
    create_teacher(app, type)
  else
    p "That's not a valid type, please try again\n"
  end
end

def create_book_main(app)
  print 'Title: '
  title = gets.chomp
  print 'Author: '
  author = gets.chomp
  app.create_book(title, author)
  print "Book '#{title}' added successfully(press enter)"
  gets.chomp
end

def rentals_list(app)
  if app.people_exist?
    app.list_people
    print 'Select person by their id: '
    id = gets.chomp
    id = id.to_i
    person = app.search_by_id(id)
    if person
      if person.rentals.length.positive?
        app.list_rentals(person)
      else
        puts("This person doesn't have any rentals\n")
      end
    else
      puts("There are not people added yet\n")
    end
    print 'Press enter to continue...'
  else
    print 'There are not people added yet(press enter)'
  end
  gets.chomp
end

def create_rental_main(app)
  if app.books.length.positive?
    if app.people_exist?
      app.list_people
      print 'Select person for a book rental by their id: '
      id = gets.chomp.to_i
      app.list_books
      print 'Select book to rent by number: '
      book_idx = gets.chomp.to_i
      print 'Date(yyyy-mm-dd):'
      date = gets.chomp
      person = app.search_by_id(id)
      app.create_rental(date, person, app.books[book_idx])
      print('Rental created successfully')
    else
      print 'There are not people added yet'
    end
  else
    print 'There are not any books to rent'
  end
  gets.chomp
end

def options_list
  print <<~HEREDOC
    1. List all books
    2. List all people
    3. Create a person
    4. Create a book
    5. Create a rental
    6. List all rentals for a given person id
    7. Exit
  HEREDOC

  print "\nSelect an option by number: "

  selection = gets.chomp
  selection.to_i
end

def exit(_app)
  print "Are you sure that you want to stop the application?(y/n)\n"
  /y/i.match?(gets.chomp) == false
end

def selection_cases(selection, app)
  cases = {
    '1' => method(:book_list),
    '2' => method(:people_list),
    '3' => method(:create_person),
    '4' => method(:create_book_main),
    '5' => method(:create_rental_main),
    '6' => method(:rentals_list),
    '7' => method(:exit)
  }

  chosen = cases[selection.to_s]
  chosen&.call(app)
end

def main
  app = App.new
  running = true
  while running
    selection = options_list
    running = selection_cases(selection, app)
  end
end

main
