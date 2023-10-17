require_relative 'app'
require_relative 'book_operations'
require_relative 'people_operations'

def main
  app = App.new
  running = true

  while running
    selection = options_list
    running = selection_cases(selection, app)
  end
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
    '1' => BookOperations.method(:book_list),
    '2' => PeopleOperations.method(:people_list),
    '3' => PeopleOperations.method(:create_person),
    '4' => BookOperations.method(:create_book_main),
    '5' => PeopleOperations.method(:create_rental_main),
    '6' => PeopleOperations.method(:rentals_list),
    '7' => method(:exit)
  }

  chosen = cases[selection.to_s]
  chosen&.call(app)
end

main
