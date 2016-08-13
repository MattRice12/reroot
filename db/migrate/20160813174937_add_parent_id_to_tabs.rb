class AddParentIdToTabs < ActiveRecord::Migration[5.0]
  def change
    add_column :tabs, :parent_tab_id, :integer
  end
end
