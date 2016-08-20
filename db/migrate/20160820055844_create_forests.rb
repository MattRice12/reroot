class CreateForests < ActiveRecord::Migration[5.0]
  def change
    create_table :forests do |t|
      t.belongs_to :project, foreign_key: true
      t.belongs_to :tree, foreign_key: true

      t.timestamps
    end
  end
end
