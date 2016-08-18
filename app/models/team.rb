class Team < ApplicationRecord
  has_many :members, dependent: :destroy
  has_many :users, through: :members

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 125 }

  # default_scope order: 'teams.name'
end
