class Member < ApplicationRecord
  belongs_to :user
  belongs_to :team

  def all_users_except(obj, identifier)
    Users.all = User.where(identifier: obj.id)
  end
end
