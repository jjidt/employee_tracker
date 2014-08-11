class Employee < ActiveRecord::Base
  belongs_to :divisions
  has_many :assignments
  has_many :projects, through: :assignments
end
