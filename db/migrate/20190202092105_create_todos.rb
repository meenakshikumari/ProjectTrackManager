class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :name
      t.text   :description
      t.string :status, default: "New"

      t.belongs_to :project

      t.timestamps
    end
  end
end
