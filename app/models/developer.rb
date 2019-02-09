class Developer < User

  has_and_belongs_to_many :assigned_projects, class_name: 'Project', foreign_key: 'user_id', join_table: 'assigned_projects_developers'

  has_and_belongs_to_many :assigned_todos, class_name: 'Todo', foreign_key: 'user_id', join_table: 'assigned_todos_developers'
end
