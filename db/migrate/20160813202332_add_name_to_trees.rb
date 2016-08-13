class AddNameToTrees < ActiveRecord::Migration[5.0]
  def change
    add_column :trees, :name, :string
  end
end
