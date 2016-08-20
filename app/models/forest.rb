class Forest < ApplicationRecord
  belongs_to :project
  belongs_to :tree
end
