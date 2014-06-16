require 'rails_helper'

RSpec.describe "orders/index", :type => :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        :order_number => "Order Number",
        :on_hold => false
      ),
      Order.create!(
        :order_number => "Order Number",
        :on_hold => false
      )
    ])
  end

  it "renders a list of orders" do
    render
    assert_select "tr>td", :text => "Order Number".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
