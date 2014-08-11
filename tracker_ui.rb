require 'active_record'
require 'pry'
require './lib/employee'
require './lib/division'
require './lib/project'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  system("clear")
  puts "EMPLOYEE TRACKER"
  menu
end

def ws
  puts "\n"
end

def menu
  puts "AE > Add an employee"
  puts "LE > List employees"
  ws
  puts "AD > Add a division"
  puts "LD > List divisions"
  ws
  puts "ED > Assign employee to a division"
  puts "SE > Show employees in a division"
  ws
  puts "AP > Add a project"
  puts "LP > List projects"
  puts "PE > Assign project to employee"
  ws
  puts "S > Search for an employee"
  puts "E > Exit"

  case gets.chomp.upcase
  when 'AE'
    add_employee
  when 'LE'
    list_employees
  when 'AD'
    add_division
  when 'LD'
    list_divisions
  when 'ED'
    assign_division
  when 'SE'
    show_employees
  when 'AP'
    add_project
  when 'LP'
    list_projects
  when 'PE'
    assign_project
  when 'S'
    search
  when 'E'
    exit
  end
  menu
end

def add_employee
  puts "Enter the new employee's name:"
  new_employee = Employee.create(:name => gets.chomp)
  puts "'#{new_employee.name}' created!"
  menu
end

def list_employees
  puts "Employees:"
  Employee.all.each {|employee| puts "#{employee.name}"}
end

def search
  puts "Enter the employee's name you want to search for:"
  test = Employee.where(:name => gets.chomp).all.each {|employee| puts "#{employee.name}"}
end

def add_division
  puts "Enter the name of a new division:"
  new_division = Division.create(:name => gets.chomp)
  puts "'#{new_division.name}' created!"
end

def list_divisions
  puts "Divisions:"
  Division.all.each {|division| puts "#{division.name}"}
end

def assign_division
  puts "Which employee do you want to assign a division to?"
  list_employees
  employee = Employee.where(:name => gets.chomp).first
  puts "Which division should #{employee.name} be in?"
  list_divisions
  division = Division.where(:name => gets.chomp).first
  employee.update(:division_id => division.id)
end

def add_project
  puts "Enter the name of the project:"
  new_project = Project.create(:name => gets.chomp)
  puts "'#{new_project.name}' created!"
end

def list_projects
  puts "Projects:"
  Project.all.each {|project| puts "#{project.name}"}
end

def assign_project
  puts "Which employee do you want to assign a project to?"
  list_employees
  employee = Employee.where(:name => gets.chomp).first
  puts "Which project should #{employee.name} have?"
  list_projects
  project = Project.where(:name => gets.chomp).first
  employee.projects << project
end

def show_employees
  puts "Enter a division to list employees in that division"
  list_divisions
  division = Division.where(:name => gets.chomp).first
  division.employees.each {|employee| puts employee.name}
end
welcome
