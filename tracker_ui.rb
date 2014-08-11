require 'active_record'
require 'pry'
require './lib/employee'
require './lib/division'

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
  puts "ED > Assign employee to a division"
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
  puts "Employees:"
  Employee.all.each {|employee| puts "#{employee.name}"}
  menu
end

def search
  puts "Enter the employee's name you want to search for:"
  test = Employee.where(:name => gets.chomp).all.each {|employee| puts "#{employee.name}"}
  menu
end

def add_division
  puts "Enter the name of a new division:"
  new_division = Division.create(:name => gets.chomp)
  puts "'#{new_division.name}' created!"
  menu
end

def list_divisions
  puts "Divisions:"
  Division.all.each {|division| puts "#{division.name}"}
  menu
end

welcome
