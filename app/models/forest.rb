class Forest < ApplicationRecord
  belongs_to :project, touch: true
  belongs_to :tree, touch: true

  # def as_json(_ = nil)
  #   super(include: [:forest])
  # end

end
