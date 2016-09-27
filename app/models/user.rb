class User < ApplicationRecord
  include Clearance::User
  before_save :blank_name, only: [:update, :edit]

  has_many  :tabs
  has_many  :trees

  has_many  :members, dependent: :destroy
  has_many  :projects, through:   :members

  validates :name,     presence:  true, uniqueness: true
  validates :email,    presence:  true, uniqueness: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  def as_json(_ = nil)
    super(include: [:user])
  end

  # def project_member?(project)
  #   members.find_by(project_id: project.id)
  # end


  def blank_name
    if self.name == ""
      self.name = self.url
    end
  end


end
