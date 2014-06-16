require 'rails_helper'

RSpec.describe "orders/new", :type => :view do
  before(:each) do
    assign(:order, Order.new(
      :order_number => "MyString",
      :on_hold => false
    ))
  end

  it "renders new order form" do
    render

    assert_select "form[action=?][method=?]", orders_path, "post" do

      assert_select "input#order_order_number[name=?]", "order[order_number]"

      assert_select "input#order_on_hold[name=?]", "order[on_hold]"
    end
  end
end
