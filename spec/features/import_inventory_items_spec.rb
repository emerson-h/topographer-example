require 'spec_helper'

feature 'Inventory Item Spreadsheet Import' do
  background do

  end
  scenario 'user imports an inventory items spreadsheet' do
    visit inventory_items_path
    click_on 'Import Inventory Items'

    expect {
      within('.import-form') do
        attach_file('import_file', 'spec/fixtures/valid_inventory_items_import.xlsx')
        click_on('Import')
      end
    }.to change { InventoryItem.count }.by(3)
  end
  scenario 'user imports inventory items with invalid model information' do
    visit inventory_items_path
    click_on 'Import Inventory Items'

    expect {
      within('.import-form') do
        attach_file('import_file', 'spec/fixtures/invalid_inventory_items_import.xlsx')
        click_on('Import')
      end
    }.to change { InventoryItem.count }.by(0)

    page.should have_content /Unable to import/i
  end
  scenario 'user imports an inventory item spreadsheet with invalid headers' do
    visit inventory_items_path
    click_on 'Import Inventory Items'

    within('.import-form') do
      attach_file('import_file', 'spec/fixtures/invalid_header_inventory_items_import.xlsx')
      click_on('Import')
    end

    page.should have_content /Invalid Columns/i
  end
end
