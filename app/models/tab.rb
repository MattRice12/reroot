class Tab < ApplicationRecord
  before_save :default_tab_name
  before_save :set_tree_id_to_tabs

  has_many   :children, -> { order :id }, class_name: "Tab", foreign_key: :parent_tab_id
  belongs_to :parent, class_name: "Tab", foreign_key: :parent_tab_id, optional: true

  belongs_to :tree, optional: true
  belongs_to :user

  # scope :top_level, -> { where(parent_tab_id: nil) }

  def as_json(_ = nil)
    super(include: [:obj])
  end

  def tab_root
    tab = self
    while tab.parent
      tab = tab.parent
    end
    tab.tree
  end

#
# ## These guys grab allllllllll tabs from the root tab down
# ## This does not grab the tab from any particular position that you call the method
#   def descendants
#     self_and_descendants - [self]
#   end
#
#   def self_and_descandants
#     self.class.tree_for(self)
#   end
#
#   def self.tree_for(instance)
#     where("\"tabs\".id IN (#{tree_sql_for(instance)})") #.order("tabs.id")
#   end
#
# ##This is a recursive search from the root tab to all the rest; it can only start where parent_tab_id = null
#   def self.tree_sql_for(instance)
#    <<-SQL
#      WITH RECURSIVE search_tab(id, path) AS (
#          SELECT id, ARRAY[id]
#          FROM tabs
#          WHERE parent_tab_id IS NULL AND
#          tabs.id = #{instance.id}
#        UNION ALL
#          SELECT tabs.id, path || tabs.id
#          FROM search_tab
#          JOIN tabs ON tabs.parent_tab_id = search_tab.id
#          WHERE NOT tabs.id = ANY(path)
#      )
#      SELECT id FROM search_tab ORDER BY path
#    SQL
#   end

  def default_tab_name
    if self.name == ""
      self.name = self.url
    end
  end

  def set_tree_id_to_tabs
    self.tree_id = self.tab_root.id
  end
end
