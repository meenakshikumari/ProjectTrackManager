class Todo < ApplicationRecord

  belongs_to :project

  has_and_belongs_to_many :developers, class_name: 'Developer',
   association_foreign_key: 'user_id', join_table: 'assigned_todos_developers'

  validates :name, presence: :true, uniqueness: {scope: :project_id,  case_sensitive: false}

  validates :status, inclusion: { in: %w(New InProgress Done),
    message: "%{value} is not a valid status" }
end
