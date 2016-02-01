class Customer < ActiveRecord::Base

  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :name, presence: true

  has_many :orders
  has_one :billing_address, class_name: 'Address', as: :addressable
  has_one :primary_shipping_address, class_name: 'Address', as: :addressable
  has_one :secondary_shipping_address, class_name: 'Address', as: :addressable

  accepts_nested_attributes_for :billing_address, :primary_shipping_address, :secondary_shipping_address
end
