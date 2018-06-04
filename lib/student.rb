require_relative "../config/environment.rb"

class Student

  attr_accessor :name, :grade, :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
  end

  def self.create_table
    DB[:conn].execute("CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER)")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  def save
    if self.id
      self.update
    else
      DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?)",self.name, self.grade)
      self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end
  end

  def self.create(name, grade)
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?)",name, grade)
  end

  def self.new_from_db(row)
    binding.pry
    self.new(row[1], row[2], row[0])
    binding.pry
  end

  def self.find_by_name(name)

  end

  def update

  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]


end
