class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|

      t.string :name
      t.text   :description

      t.belongs_to :manager

      t.timestamps
    end
  end
end
