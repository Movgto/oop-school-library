require_relative 'app'
require_relative 'app/models/data_handler'

class Launcher
  include Library
  include DataHandler
  # Print list of Main options
  def option_list
    puts 'Please choose an option by intering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
    gets.chomp
  end

  def use_cases(choice)
    people = gather_people
    books = gather_books
    rentals = gather_rentals(books, people)

    data = {
      people: people,
      books: books,
      rentals: rentals
    }

    options = {
      '1' => method(:get_list_books),
      '2' => method(:get_list_person),
      '3' => method(:add_new_person),
      '4' => method(:add_new_book),
      '5' => method(:create_new_rental),
      '6' => method(:get_user_rental),
      '7' => method(:exit)
    }

    return wrong_number_msg if options[choice].nil?

    options[choice].call(data)
  end
  # rubocop:enable Metrics/CyclomaticComplexity
end

# The entry point method
def main
  puts "\nWelcome to School Library App!"
  puts "\n"
  running = true
  while running
    choice = Launcher.new.option_list
    response = Launcher.new.use_cases(choice)
    running = response.nil? || response == true
  end
end

main
