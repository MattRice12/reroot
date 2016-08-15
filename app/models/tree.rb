class Tree < ApplicationRecord
  has_many   :tabs
  belongs_to :user
end
