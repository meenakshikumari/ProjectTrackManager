class CreateAssignedProjectsDeveloper < ActiveRecord::Migration[5.2]
  def change
    create_table :assigned_projects_developers do |t|
      t.belongs_to :project, index: :true
      t.belongs_to :user, index: :true
    end
  end
end
