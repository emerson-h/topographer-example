require 'rails_helper'

RSpec.describe "inventory_items/index", :type => :view do
  before(:each) do
    assign(:inventory_items, [
      InventoryItem.create!(
        :name => "Name",
        :description => "MyText",
        :quantity => 1,
        :unit_price => 1.5,
        :enabled => false,
        :sku_code => "Sku Code"
      ),
      InventoryItem.create!(
        :name => "Name",
        :description => "MyText",
        :quantity => 1,
        :unit_price => 1.5,
        :enabled => false,
        :sku_code => "Sku Code"
      )
    ])
  end

  it "renders a list of inventory_items" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Sku Code".to_s, :count => 2
  end
end
