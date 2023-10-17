

class BookOperations
  def self.book_list(app)
    print "Book list:\n"
    if app.books.length.positive?
      app.list_books
      print 'Press enter to continue'
    else
      print 'There are not any books added yet'
    end
    gets.chomp
  end

  def self.create_book_main(app)
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    app.create_book(title, author)
    print "Book '#{title}' added successfully(press enter)"
    gets.chomp
  end
end
