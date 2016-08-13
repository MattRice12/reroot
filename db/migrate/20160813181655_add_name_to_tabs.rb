class AddNameToTabs < ActiveRecord::Migration[5.0]
  def change
    add_column :tabs, :name, :string
  end
end
