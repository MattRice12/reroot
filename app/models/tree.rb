class Tree < ApplicationRecord
  has_many   :tabs,     dependent: :destroy
  has_many   :forests,  dependent: :destroy
  has_many   :projects, through:   :forests

  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
end
