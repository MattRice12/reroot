class Tree < ApplicationRecord
  has_many   :tabs,     dependent: :destroy
  has_many   :forests,  dependent: :destroy
  has_many   :projects, through:   :forests

  belongs_to :user, touch: true

  validates :name, presence: true, length: { maximum: 50 }

  def as_json(_ = nil)
    super(include: [:tree])
  end

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

  def branch_count
    # self.tabs.where.not(parent_tab_id: nil).map { |tab| tab.parent_tab_id }.uniq.count
    self.tabs.where.not(parent_tab_id: nil).distinct.count(:parent_tab_id)
  end

  def tab_count
    self.tabs.count
  end

  def user_tab_count(user)
    self.tabs.where(user_id: user.id).count
  end

  def project_count
    self.forests.where(tree_id: self.id).count
  end
end
