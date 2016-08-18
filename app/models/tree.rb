class Tree < ApplicationRecord
  has_many   :tabs, dependent: :destroy
  belongs_to :user
end
