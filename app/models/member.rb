class Member < ApplicationRecord
  belongs_to :user
  belongs_to :project

  def as_json(_ = nil)
    super(include: [:member])
  end

  def all_users_except(obj, identifier)
    Users.all = User.where(identifier: obj.id)
  end

end
