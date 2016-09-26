class Forest < ApplicationRecord
  belongs_to :project
  belongs_to :tree

  # def as_json(_ = nil)
  #   super(include: [:forest])
  # end

end
