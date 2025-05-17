class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :delivery_time_id, :price,
            presence: true
end
