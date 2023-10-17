

class PeopleOperations
    def self.people_list(app)
      if app.people_exist?
        app.list_people
        print "\nPress enter to continue\n"
      else
        print "There are not any people added yet\n"
        print "Press enter to continue\n"
      end
      gets.chomp
    end
  
    def self.create_person(app)
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
  
    def self.rentals_list(app)
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
  
    def self.create_rental_main(app)
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
  end
  