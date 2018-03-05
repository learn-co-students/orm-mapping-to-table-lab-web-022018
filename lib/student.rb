class Student

  attr_reader :id
  attr_accessor :name, :grade

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def self.create_table
    sql =  <<-SQL
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
        SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
      sql =  <<-SQL
        DROP TABLE students
          SQL
      DB[:conn].execute(sql)
  end

  def save
        sql = <<-SQL
          INSERT INTO students (name, grade)
          VALUES (?, ?)
        SQL
        DB[:conn].execute(sql, @name, @grade)
        @id = DB[:conn].execute("select last_insert_rowid() from students")[0][0]
      end


  def self.create(name:, grade:)
      student = Student.new(name, grade)
      student.save
      student
  end
end
