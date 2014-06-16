require 'rails_helper'

RSpec.describe "orders/show", :type => :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :order_number => "Order Number",
      :on_hold => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Order Number/)
    expect(rendered).to match(/false/)
  end
end
