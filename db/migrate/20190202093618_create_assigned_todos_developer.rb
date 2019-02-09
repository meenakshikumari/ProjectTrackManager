class CreateAssignedTodosDeveloper < ActiveRecord::Migration[5.2]
  def change
    create_table :assigned_todos_developers do |t|
      t.belongs_to :todo, index: :true
      t.belongs_to :user, index: :true
    end
  end
end
