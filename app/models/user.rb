class User < ApplicationRecord
  include Clearance::User

  has_many  :trees
  has_many  :tabs

  has_many  :members,  dependent: :destroy
  has_many  :projects, through:   :members

  validates :name,     presence:  true, uniqueness: true
  validates :email,    presence:  true, uniqueness: true
  validates :password, presence:  true

  def project_member?(project)
    members.find_by(project_id: project.id)
  end

end
