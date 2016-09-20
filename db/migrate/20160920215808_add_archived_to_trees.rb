class AddArchivedToTrees < ActiveRecord::Migration[5.0]
  def change
    add_column :trees, :archived, :boolean
  end
end
