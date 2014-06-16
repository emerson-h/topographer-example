require 'rails_helper'

RSpec.describe "inventory_items/new", :type => :view do
  before(:each) do
    assign(:inventory_item, InventoryItem.new(
      :name => "MyString",
      :description => "MyText",
      :quantity => 1,
      :unit_price => 1.5,
      :enabled => false,
      :sku_code => "MyString"
    ))
  end

  it "renders new inventory_item form" do
    render

    assert_select "form[action=?][method=?]", inventory_items_path, "post" do

      assert_select "input#inventory_item_name[name=?]", "inventory_item[name]"

      assert_select "textarea#inventory_item_description[name=?]", "inventory_item[description]"

      assert_select "input#inventory_item_quantity[name=?]", "inventory_item[quantity]"

      assert_select "input#inventory_item_unit_price[name=?]", "inventory_item[unit_price]"

      assert_select "input#inventory_item_enabled[name=?]", "inventory_item[enabled]"

      assert_select "input#inventory_item_sku_code[name=?]", "inventory_item[sku_code]"
    end
  end
end
