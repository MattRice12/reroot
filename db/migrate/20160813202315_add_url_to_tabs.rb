class AddUrlToTabs < ActiveRecord::Migration[5.0]
  def change
    add_column :tabs, :url, :text
  end
end
