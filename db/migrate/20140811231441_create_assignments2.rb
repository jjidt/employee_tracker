class CreateAssignments2 < ActiveRecord::Migration
  def change
    drop_table :assignments
    create_table :assignments, id: false do |t|
      t.belongs_to :employee
      t.belongs_to :project
    end
  end
end
