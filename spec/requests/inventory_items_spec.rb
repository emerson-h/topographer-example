require 'rails_helper'

RSpec.describe "InventoryItems", :type => :request do
  describe "GET /inventory_items" do
    it "works! (now write some real specs)" do
      get inventory_items_path
      expect(response.status).to be(200)
    end
  end
end
