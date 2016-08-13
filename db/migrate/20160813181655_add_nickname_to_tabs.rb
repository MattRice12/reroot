class AddNicknameToTabs < ActiveRecord::Migration[5.0]
  def change
    add_column :tabs, :nickname, :string
  end
end
