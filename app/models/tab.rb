class Tab < ApplicationRecord
  has_many :children, class_name: "Tab", foreign_key: :parent_tab_id
  belongs_to :parent, class_name: "Tab", foreign_key: :parent_tab_id, optional: true

  belongs_to :tree


end
