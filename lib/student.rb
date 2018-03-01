class Student
  attr_accessor :name, :grade
  attr_reader :id

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
  end

  def self.create_table
    sql_command =  <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      );
      SQL
    DB[:conn].execute(sql_command)
  end

  def self.drop_table
    sql_command = <<-SQL
      DROP TABLE students;
    SQL
    DB[:conn].execute(sql_command)
  end

  def save
    sql_command = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?);
    SQL
    DB[:conn].execute(sql_command, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end
end
