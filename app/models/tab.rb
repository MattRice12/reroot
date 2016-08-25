class Tab < ApplicationRecord
  before_save :default_tab_name
  before_save :set_tree_id_to_tabs

  has_many   :children, -> { order :id }, class_name: "Tab", foreign_key: :parent_tab_id
  belongs_to :parent, class_name: "Tab", foreign_key: :parent_tab_id, optional: true, touch: true

  belongs_to :tree, optional: true, touch: true
  belongs_to :user, touch: true

  # def as_json(_ = nil)
  #   super(include: [:tab])
  # end

  def tab_root
    tab = self
    while tab.parent
      tab = tab.parent
    end
    tab.tree
  end

  def default_tab_name
    if self.name == ""
      self.name = self.url
    end
  end

  def set_tree_id_to_tabs
    self.tree_id = self.tab_root.id
  end
end
