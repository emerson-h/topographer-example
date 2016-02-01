class Address < ActiveRecord::Base
  include Comparable

  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  belongs_to :addressable, polymorphic: true

  def <=>(other)
    return -1 if other.nil?
    comp = other.zip <=> zip
    comp = other.state.downcase <=> state.downcase if comp == 0
    comp = other.city.downcase <=> city.downcase if comp == 0
    comp = other.street.downcase <=> street.downcase if comp == 0
    comp
  end
end
