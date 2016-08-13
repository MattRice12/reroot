class User < ApplicationRecord
  has_many :trees

  validates :name, presence: true
  validates :email, presence: true
end
