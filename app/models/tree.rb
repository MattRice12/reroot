class Tree < ApplicationRecord
  default_scope { order('trees.created_at DESC') }
  before_save :default_tree_archived
  before_update :default_tree_archived

  has_many   :tabs,     dependent: :destroy
  has_many   :forests,  dependent: :destroy
  has_many   :projects, through:   :forests

  belongs_to :user, optional: true

  validates :name, presence: true, length: { maximum: 50 }
  # validates :archived,

  # def as_json(_ = nil)
  #   super(include: [:tree])
  # end

  def self.all_branches_for(tree)
    tabs = Tab.find_by_sql(
    """
      SELECT * FROM tabs
      AS a
      WHERE
      (SELECT COUNT (*) FROM tabs AS b
      WHERE b.parent_tab_id = a.id) > 1;
    """
    )
    # Replace with recursive SQL query (or add tree_id to all tabs)
    tabs.select { |tab| tab.tab_root == tree }
  end

  def self.all_branches_on(tree)
    Tab.where(tree_id: tree.id).where(parent_tab_id)
  end

  def user_tab_count(user)
    self.tabs.where(user_id: user.id).count
  end

  def project_count
    # self.forests.where(tree_id: self.id).count
    self.forests.count_by_sql(
    """
      SELECT COUNT(projects.id)
      FROM projects
      JOIN forests
      ON projects.id = forests.project_id
      JOIN trees
      ON trees.id = forests.tree_id
      WHERE forests.tree_id = #{self.id};
    """
    )
  end

  def branch_count
    # self.tabs.where.not(parent_tab_id: nil).map { |tab| tab.parent_tab_id }.uniq.count
    # self.tabs.where.not(parent_tab_id: nil).distinct.count(:parent_tab_id)
    self.tabs.count_by_sql(
    """
      SELECT COUNT(DISTINCT tabs.parent_tab_id)
      FROM tabs, trees
      WHERE tabs.tree_id = trees.id AND trees.id = #{self.id} AND tabs.parent_tab_id IS NOT NULL;
    """
    )
  end

  def tab_count
    # self.tabs.count
    self.tabs.count_by_sql(
    """
      SELECT COUNT(tabs.id)
      FROM tabs, trees
      WHERE tabs.tree_id = trees.id AND trees.id = #{self.id};
    """
    )
  end

  def default_tree_archived
    if self.archived == nil
      self.archived = false
    end
  end
end
