class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @id = Random.rand(1..10000)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(rental)
    @rentals.push(rental)
  end

  def save
    book = {
      "title" => @title,
      "author" => @author,
    }

    opts = {
      array_nl: "\n",
      object_nl: "\n",
      indent: '  ',
      space_before: ' ',
      space: ' '
    }

    if File.exist?('./data/books.json') 
      books = JSON.parse(
        File
        .open('./data/books.json')
        .read
      )

      books.push(book)

      File.write('./data/books.json', JSON.generate(books, opts))

      p "Books ", books

    else
      File.write('./data/books.json', JSON.generate([book], opts))
    end
  end
end
