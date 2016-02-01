require 'rails_helper'

feature 'Order Spreadsheet Import' do
  before do
    customer = Customer.create!(
      email: 'bob@dev.null',
      name: 'Bob'
    )
    customer.create_primary_shipping_address(
      street: '123 Fake St 1',
      city: 'Durham',
      state: 'NC',
      zip: 27701
    )
    InventoryItem.create!(
      name: 'Widget 1',
      sku_code: 'WS123',
      description: 'Some widget',
      quantity: 123,
      unit_price: 10.00
    )
    InventoryItem.create!(
      name: 'Widget 2',
      sku_code: 'WS124',
      description: 'Some widget',
      quantity: 50,
      unit_price: 10.00
    )
    InventoryItem.create!(
      name: 'Widget 3',
      sku_code: 'WS125',
      description: 'Some widget',
      quantity: 13,
      unit_price: 10.00
    )
    InventoryItem.create!(
      name: 'Widget 4',
      sku_code: 'WS126',
      description: 'Some widget',
      quantity: 103,
      unit_price: 10.00
    )
  end
  scenario 'user imports an orders spreadsheet' do

    visit orders_path
    click_on 'Import Orders'

    expect {
      within('.import-form') do
        attach_file('import_file', 'spec/fixtures/valid_order_import.xlsx')
        click_on('Import')
      end
    }.to change { Order.count }.by(2)
      .and change { OrderItem.count }.by(5)
  end
  scenario 'user imports an invalid orders spreadsheet' do

    visit orders_path
    click_on 'Import Orders'

    expect {
      within('.import-form') do
        attach_file('import_file', 'spec/fixtures/invalid_order_import.xlsx')
        click_on('Import')
      end
    }.to change { Order.count }.by(0)
      .and change { OrderItem.count }.by(0)
  end

  scenario 'user imports order spreadsheet with invalid headers' do
    visit orders_path
    click_on 'Import Orders'

    within('.import-form') do
      attach_file('import_file', 'spec/fixtures/invalid_header_order_import.xlsx')
      click_on('Import')
    end

    page.should have_content /Missing Columns/i
  end
end
