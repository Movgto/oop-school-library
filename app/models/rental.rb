class Rental
  attr_accessor :date, :person, :book

  def initialize(person, book, date)
    @date = date
    @person = person
    person.rentals << self
    @book = book
    book.rentals << self
  end

  def save(people_list, books_list)
    person_idx = people_list.find_index {|el| el == @person}
    book_idx = books_list.find_index {|el| el == @book}

    rental = {
      "person_idx" => person_idx,
      "book_idx" => book_idx,
      "date" => @date,
    }

    opts = {
      array_nl: "\n",
      object_nl: "\n",
      indent: '  ',
      space_before: ' ',
      space: ' '
    }

    if File.exist?('./data/rentals.json') 
      rentals = JSON.parse(
        File
        .open('./data/rentals.json')
        .read
      )

      rentals.push(rental)

      File.write('./data/rentals.json', JSON.generate(rentals, opts))

    else
      File.write('./data/rentals.json', JSON.generate([rental], opts))
    end
  end
end
