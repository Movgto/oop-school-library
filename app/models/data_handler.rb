require 'json'

module DataHandler
  def save_element(element, name)
    opts = {
      array_nl: "\n",
      object_nl: "\n",
      indent: '  ',
      space_before: ' ',
      space: ' '
    }
    if File.exist?("./data/#{name}.json")
      data = JSON.parse(
        File.read("./data/#{name}.json")
      )
      data.push(element)
      File.write("./data/#{name}.json", JSON.generate(data, opts))
    else
      File.write("./data/#{name}.json", JSON.generate([data], opts))
    end
  end

  # Methods for gathering people, books, and rentals data
  # stored in the files previously saved.
  # Returns an array populated with class objects according
  # to the data type and properties for each element in the
  # incoming data.
  # If there is not any existing data simply returns an empty array
  def gather_people
    people = []
    if File.exist?('./data/students.json')
      data = JSON.parse(
        File
        .read('./data/students.json')
      )
      data = data.map { |el| Student.new(nil, el['age'], el['name']) }
      people.concat(data)
    end

    if File.exist?('./data/teachers.json')
      data = JSON.parse(
        File
        .read('./data/teachers.json')
      )

      data = data.map { |el| Teacher.new(el['specialization'], el['age'], el['name']) }
      people.concat(data)
    end

    people
  end

  def gather_books
    books = []
    if File.exist?('./data/books.json')
      data = JSON.parse(
        File
        .read('./data/books.json')
      )
      data = data.map { |el| Book.new(el['title'], el['author']) }
      books.concat(data)
    end

    books
  end

  def gather_rentals(book_list, people_list)
    rentals = []
    if File.exist?('./data/rentals.json')
      data = JSON.parse(
        File
        .read('./data/rentals.json')
      )

      data = data.map do |el|
        person = people_list[el['person_idx']]
        book = book_list[el['book_idx']]

        Rental.new(person, book, el['date'])
      end

      rentals.concat(data)
    end

    rentals
  end
end
