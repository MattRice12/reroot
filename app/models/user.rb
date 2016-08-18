class User < ApplicationRecord
  include Clearance::User

  has_many :trees

  has_many :members, dependent: :destroy
  has_many :teams, through: :members

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true

  def team_member?(team)
    members.find_by(team_id: team.id)
  end
end
