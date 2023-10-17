# Main.rb

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
  # Your options_list logic here
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
