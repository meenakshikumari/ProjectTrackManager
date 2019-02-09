class Project < ApplicationRecord
  belongs_to :manager

  has_and_belongs_to_many :developers, class_name: 'Developer', association_foreign_key: 'user_id', join_table: 'assigned_projects_developers'

  has_many :todos, dependent: :destroy

  validates :name, presence: :true, uniqueness: true
end
