require 'spec_helper'

feature 'Customer Spreadsheet Import' do
  background do

  end
  scenario 'user imports an customers spreadsheet' do
    visit customers_path
    click_on 'Import Customers'

    expect {
      within('.import-form') do
        attach_file('import_file', 'spec/fixtures/valid_customer_import.csv')
        click_on('Import')
      end
    }.to change { Customer.count }.by(2)
  end
  scenario 'user imports customers with missing information' do
    visit customers_path
    click_on 'Import Customers'

    within('.import-form') do
      attach_file('import_file', 'spec/fixtures/valid_customer_import.csv')
      click_on('Import')
    end

    page.should have_content /Unable to import customers/i
  end
  scenario 'user imports customer spreadsheet with invalid headers' do
    visit customers_path
    click_on 'Import Customers'

    within('.import-form') do
      attach_file('import_file', 'spec/fixtures/invalid_customer_import.csv')
      click_on('Import')
    end

    page.should have_content /Invalid Columns/i
  end
end
