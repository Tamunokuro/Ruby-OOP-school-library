require_relative './student'
require_relative './book'
require_relative './rental'
require_relative './teacher'
require_relative './classroom'
require 'date'

# rubocop:disable Metrics
class App
  def initialize
    @people = []
    @books = []
    @rentals = []
    @class = Classroom.new('Grade 5')
  end

  def list_books
    puts 'No books added!' if @books.empty?

    @books.each { |book| puts "Title: #{book.title}, author: #{book.author}" }
    puts ''
  end

  def list_people
    puts 'No person added!' if @people.empty?

    @people.map { |person| puts "[#{person.class}] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}" }
    puts ''
  end

  def create_person
    print 'Select (1) to create Student and (2) to create Teacher: '
    choice = gets.chomp
    case choice
    when '1'
      create_student
    when '2'
      create_teacher
    else
      print 'Invalid input! Please select either 1  or 2: '
    end
  end

  def create_student
    print 'Enter age: '
    age = gets.chomp.to_i

    print 'Enter your name: '
    name = gets.chomp

    print 'Parent permission [y/n]:'
    permission = gets.chomp

    new_student = Student.new(@classroom, age, name, parent_permission: permission)
    @people.push(new_student)

    puts "Student #{name.upcase} created successfully"
  end

  def create_teacher
    print 'Enter age: '
    age = gets.chomp.to_i

    print 'Enter your name: '
    name = gets.chomp

    print 'Enter specialization: '
    specialization = gets.chomp

    new_teacher = Teacher.new(specialization, age, name)
    @people.push(new_teacher)

    puts "Teacher #{name.upcase} created successfully"
  end

  def create_book
    print 'Enter book title: '
    title = gets.chomp

    print 'Enter book author: '
    author = gets.chomp

    new_book = Book.new(title, author)
    @books.push(new_book)

    puts "#{title} by #{author} created successfully"
  end

  def create_rental
    if @books.empty? || @people.empty?
      puts 'There are no books or people'
    else
      print 'Date of book rental: '
      date = gets.chomp.to_s

      puts 'Please select the id of the book from the list of books'
      @books.each_with_index { |book, index| puts "#{index}. #{book.title} by #{book.author}" }

      book_id = gets.chomp.to_i
      if (0..@books.length - 1).include?(book_id)
        puts 'Please select person id from list of people'
        @people.each_with_index { |person, index| puts "#{index}. #{person.name}" }
        person_id = gets.chomp.to_i
        if (0..@people.length - 1).include?(person_id)
          new_rental = Rental.new(date, @books[book_id], @people[person_id])
          @rentals.push(new_rental)

          @rentals.each do |rent|
            puts "#{rent.book.title} by #{rent.book.author} rental created successfully"
          end

        else
          puts 'Invalid person id'
        end

      else
        puts 'Invalid! No book with that id'
      end
    end
  end

  def list_rentals
    if @people.empty?
      puts 'No data for people found.'
      return
    end

    print 'Enter person ID: '
    person_id = gets.chomp.to_i
    puts 'Books rentals:'
    @rentals.each do |rented|
      puts "Book #{rented.book.title} by #{rented.book.author}" if rented.person.id == person_id
    end
  end
end
# rubocop:enable Metrics
