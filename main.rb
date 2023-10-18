require_relative 'app'

class Launcher
  include Library
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

  # Method that manages main option
  # all_rentals: array of rentals
  # all_books: array of books
  # all_person: array of person
  # choice: string - option value
  # rubocop:disable Metrics/CyclomaticComplexity
  def use_cases(choice)
    people = getPeople
    books = getBooks
    rentals = getRentals(books, people)

    case choice
    when '1'
      get_list_books(books, false)
    when '2'
      get_list_person(people, false)
    when '3'
      puts 'Do you want to create a student (1) or a teacher (2) [Input the number] :'
      choice = gets.chomp
      add_new_person(people, choice)
    when '4'
      add_new_book(books)
    when '5'
      create_new_rental(rentals, books, people)
    when '6'
      get_user_rental(people)
    when '7'
      exit
    else
      wrong_number_msg
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
end

# The entry point method
def main
  puts "\nWelcome to School Library App!"
  puts "\n"

  loop do
    choice = Launcher.new.option_list
    Launcher.new.use_cases(choice)
  end
end

main
