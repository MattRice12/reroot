class Tab < ApplicationRecord
  before_save :method_name

  has_many   :children, -> { order :id }, class_name: "Tab", foreign_key: :parent_tab_id

  belongs_to :parent, class_name: "Tab", foreign_key: :parent_tab_id, optional: true
  belongs_to :tree,   optional:   true
  belongs_to :user

  def tab_root
    tab = self
    while tab.parent
      tab = tab.parent
    end
    tab.tree
  end

  def method_name
    if self.name == ""
      self.name = self.url
    end
  end

end
