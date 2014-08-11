require 'active_record'
require 'pry'
require './lib/employee'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  system("clear")
  puts "EMPLOYEE TRACKER"
  menu
end

def menu
  puts "A > Add an employee"
  puts "L > List employees"
  puts "S > Search for employee"
  puts "E > Exit"

    case gets.chomp.upcase
    when 'A'
      add_employee
    when 'L'
      list_employees
    when 'S'
      search
    when 'E'
      exit
    else
      menu
    end
end

def add_employee
  puts "Enter the new employee's name:"
  new_employee = Employee.create(:name => gets.chomp)
  puts "'#{new_employee.name}' created!"
  menu
end

def list_employees
  puts "Employees"
  Employee.all.each {|employee| puts "#{employee.name}"}
  menu
end

def search
  puts "Enter the employee's name you want to search for:"
  test = Employee.where(:name => gets.chomp).all.each {|employee| puts "#{employee.name}"}
  menu
end

welcome
