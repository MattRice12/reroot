class User < ApplicationRecord
  include Clearance::User

  has_many :trees

  validates :name, presence: true
  validates :email, presence: true
end
