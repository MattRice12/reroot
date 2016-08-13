class AddParentIdToBranches < ActiveRecord::Migration[5.0]
  def change
    add_column :branches, :parent_branch_id, :integer
  end
end
