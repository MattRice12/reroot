class Team < ApplicationRecord
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  belongs_to :user

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 125 }, uniqueness: true

  # default_scope order: 'teams.name'

  def team_members
    users.where.not(users: { id: user.id })
  end
end
