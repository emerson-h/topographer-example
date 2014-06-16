require 'rails_helper'

RSpec.describe "orders/edit", :type => :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :order_number => "MyString",
      :on_hold => false
    ))
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do

      assert_select "input#order_order_number[name=?]", "order[order_number]"

      assert_select "input#order_on_hold[name=?]", "order[on_hold]"
    end
  end
end
