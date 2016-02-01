class Order < ActiveRecord::Base

  validates :order_number, presence: true, uniqueness: true

  belongs_to :customer

  has_many :order_items

  has_one :shipping_address, class_name: 'Address', as: :addressable
end
