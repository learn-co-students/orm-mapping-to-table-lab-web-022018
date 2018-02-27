class Student

  attr_accessor :name, :grade
  attr_reader :id

  @@all = []

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
    )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students(name,grade)
    VALUES (?,?)
    SQL
    DB[:conn].execute(sql, name, grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    song = Student.new(name,grade)
    song.save
    song
  end 


end
