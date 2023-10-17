require_relative 'app'

class Main
  def main
    app = App.new
    running = true
    while running
      print "1. List all books\n2. List all people\n3. Create a person\n4. Create a book\n5. Create a rental\n6. List all rentals for a given person id\n7. Exit\n"

      print "\nSelect an option by number: "

      selection = gets.chomp
      selection = selection.to_i

      case selection
      when 1
        print "Book list:\n"
        if app.books.length > 0
          app.list_books
          print "Press enter to continue"
          gets.chomp
        else
          print "There are not any books added yet"
          gets.chomp
        end
      when 2
        if app.people_exist?
          app.list_people
          print "\nPress enter to continue\n"
          gets.chomp
        else
          print "There are not any people added yet\n"
          print "Press enter to continue\n"
          gets.chomp
        end
      when 3
        print "What type of person would you like to create?\n"
        print "1. Student\n2. Teacher\n"
        print "Type(enter option number): \n"
        type = gets.chomp
        type = type.to_i
        case type
        when 1
          print "Age: "
          age = gets.chomp
          print "Name: "
          name = gets.chomp

          only_numbers = /^\d+$/.match?(age)
          only_alpha = /[^a-z]/i.match?(name) == false
          valid = only_numbers && only_alpha
          # Check if age contains only numbers and name
          # contains only alphabetic characters

          age = age.to_i # Convert age from string to integer

          if valid
            app.create_person(type, age, name)
            print "Person created successfully(press enter)"
            gets.chomp
          else
            print "Please enter valid values"
            gets.chomp
          end
        when 2
          print "Age: "
          age = gets.chomp
          age = age.to_i
          print "Name: "
          name = gets.chomp
          print "Specialization: "
          specialization = gets.chomp

          app.create_person(type, age, name, specialization)
          print "Person '#{name}' created succesfully(press enter)"
          gets.chomp
        else
          p "That's not a valid type, please try again\n"
        end
      when 4
        print "Title: "
        title = gets.chomp
        print "Author: "
        author = gets.chomp
        app.create_book(title, author)
        print "Book '#{title}' added successfully(press enter)"
        gets.chomp
      when 5
        if app.books.length > 0
          if app.people_exist?
            app.list_people
            print "Select person for a book rental by their id\n"
            print "ID: "
            id = gets.chomp
            id = id.to_i
            app.list_books
            print "Select book to rent by number\n"
            print "Book: "
            book_idx = gets.chomp
            book_idx = book_idx.to_i
            print "Date(yyyy-mm-dd):"
            date = gets.chomp
            person = app.search_by_id(id)

            print "Creating rental with ID: #{id} Person: #{person.name} Book: #{app.books[book_idx].title}\n"

            if date != nil && app.books[book_idx] != nil && person != nil
              app.create_rental(date, person, app.books[book_idx])
              print "Rental created successfully!(press enter)"
              gets.chomp
            else
              print "Invalid values, please try again(press enter)"
              gets.chomp
            end
          else
            print "There are not people added yet\n"
            gets.chomp
          end
        else
          print "There are not any books to rent"
          gets.chomp
        end
      when 6
        if app.people_exist?
          app.list_people
          print "Select person by their id\n"
          print "ID: "
          id = gets.chomp
          id = id.to_i

          person = app.search_by_id(id)

          if person
            if person.rentals.length > 0
              app.list_rentals(person)
            else 
              print "This person doesn't have any rentals\n"
            end
            print "Press enter to continue..."
            gets.chomp
          else
            print "Invalid values, please try again(press enter)"
            gets.chomp
          end
        else
          print "There are not people added yet(press enter)"
          gets.chomp
        end
      when 7
        print "Are you sure that you want to stop the application?(y/n)\n"
        response = gets.chomp
        if /y/i.match(response)
          running = false
        end
      else

      end
    end
  end
end

main = Main.new
main.main
