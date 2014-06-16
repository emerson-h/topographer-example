class Address < ActiveRecord::Base

  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  belongs_to :addressable, polymorphic: true
end
