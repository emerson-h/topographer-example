require 'rails_helper'

RSpec.describe "inventory_items/show", :type => :view do
  before(:each) do
    @inventory_item = assign(:inventory_item, InventoryItem.create!(
      :name => "Name",
      :description => "MyText",
      :quantity => 1,
      :unit_price => 1.5,
      :enabled => false,
      :sku_code => "Sku Code"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Sku Code/)
  end
end
