require 'spec_helper'

describe Employee do
  describe "assign_employee" do
    it "assigns the given division to the specified employee" do
      maintenance = Division.create(:name => 'Maintenance')
      bob = Employee.create(:name => 'Bob', :division_id => maintenance.id)
      expect(Employee.where(:name => 'Bob').first.division_id).to eq maintenance.id
    end
  end
end

