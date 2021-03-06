require_relative "../config/environment.rb"
require 'pry'

class Student

  attr_accessor :name, :grade, :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
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
    self.new(row[1], row[2], row[0])
  end

  def self.find_by_name(name)
    row = DB[:conn].execute("SELECT * FROM students WHERE name = ?",name).flatten
    new_from_db(row)
  end

  def update
    DB[:conn].execute("UPDATE students SET name = ?, grade = ? WHERE id = ?",self.name, self.grade, self.id)
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]


end
