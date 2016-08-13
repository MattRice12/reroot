class CreateBranches < ActiveRecord::Migration[5.0]
  def change
    create_table :branches do |t|
      t.belongs_to :tree, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
