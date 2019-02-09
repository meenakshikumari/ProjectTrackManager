class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  validates :email, format: {with: Devise.email_regexp}
  validates :name, presence: :true
  validates :email, presence: :true, uniqueness: true

  # scope :manager, -> { where(type: 'Manager') }
  # scope :developer, -> { where(status: 'Developer') }

  # def self.developer
  #   true
  # end
end
