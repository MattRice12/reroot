class Project < ApplicationRecord
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  belongs_to :user

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 125 }, uniqueness: true

  # default_scope order: 'projects.name'

  def project_members
    users.where.not(users: { id: user.id })
  end

  def non_members
    # User.all - self.users

    User.where.not(id: users).order("LOWER(name)")
  end

end
