class Manager < User
  has_many :projects, foreign_key: "manager_id"
end
