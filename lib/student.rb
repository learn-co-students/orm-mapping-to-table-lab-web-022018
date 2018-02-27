class Student
  attr_accessor :name,:grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize(name,grade,id=nil)
    @name=name
    @grade=grade
    @id=id
  end #initialize

  def save
    sql = "insert into students (id,name,grade) values (?,?,?)"
    DB[:conn].execute(sql,@id,@name,@grade)
    sql="select id from students where name = ?"
    # puts "JOSH ID IS ====================#{DB[:conn].execute(sql,@name)}"
    sql="select id from students where name = ?"
    # puts "JOSH ID IS ====================#{DB[:conn].execute(sql,@name)}"
    @id=DB[:conn].execute(sql,@name)[0][0]
    #save id from db to @id
    # puts "**************#{@id}"
    # puts "******************#{DB[:conn].execute('select * from students')}"
  end

  def self.create(attrib)
    # puts "********************#{attrib[:name]}"
    student = Student.new(attrib[:name],attrib[:grade])
    student.save
    student
  end

  def self.create_table
    sql = "create table  if not exists students (id integer PRIMARY KEY,  name text,grade text)"
    DB[:conn].execute(sql )
  end #create_table

  def self.drop_table
    sql = "drop table students"
    DB[:conn].execute(sql )
  end
end
