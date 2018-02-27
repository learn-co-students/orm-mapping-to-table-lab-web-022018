class Student
	attr_accessor :name, :grade 
	attr_reader :id

	def initialize(name, grade, id=nil)
		@id = id
		@name = name
		@grade = grade

	end

	def self.create_table
		sql = <<-SQL
			create table if not exists students (
				id integer primary key,
				name text,
				grade text
			) 
		SQL

		DB[:conn].execute(sql)
	end

	def save
		sql = <<-SQL
			insert into students (name, grade) values (?, ?)
		SQL

		DB[:conn].execute(sql, @name, @grade)

		@id = DB[:conn].execute("select last_insert_rowid() from students")[0][0]
	end

	def self.create(name:, grade:)
		student = Student.new(name, grade)
		student.save
		student
	end

	def self.drop_table
		sql = <<-SQL
			drop table if exists students
		SQL

		DB[:conn].execute(sql)
	end

end
