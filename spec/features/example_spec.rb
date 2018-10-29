require 'spec_helper'

describe 'Loading the app under test' do
  
  it 'runs through the checkout flow' do
    puts 'start'
    visit('/flowers/all/')
    first('.ui-corner-all.ui-widget.ui-button-icon-only.ui-dialog-titlebar-close').click
    first('.product-summary__media-link').click
    first('.product-details__shipping-date').click
    first('td[data-handler="selectDay"]').click
    click_button('Add To Basket')
    click_link('Checkout')
    puts 'begin checkout'
    within('#checkout_form') do
      fill_in('shipping_address[][first_name]', with: 'Jane')
      fill_in('shipping_address[][last_name]', with: 'Doe')
      select 'Home', from: 'type_shipping_address_1'
      select('Self', from: 'shipping_address[][relationship_label]')
      fill_in('shipping_address[][street]', with: '1231 Wilshire Boulevard')
      fill_in('shipping_address[][city]', with: 'Santa Monica')
      select 'California', from: 'region_shipping_address_1'
      fill_in('shipping_address[][postal_code]', with: '90403')
      fill_in('shipping_address[][phone_number]', with: '3105551212')
      click_button('Continue')
      puts 'continue'
      fill_in('credit_card_number', with: '4242424242424242')
      fill_in('billing_address[name_on_card]', with: 'Testing Testing')
      select('2021', from: 'credit_card[year]')
      fill_in('credit_card[cvv]', with: '123')
      fill_in('billing_address[postal_code]', with: '90440')
      fill_in('email', with: 'alexis@thebouqs.com')
    end
    click_button('Place Order')
     puts 'checkout complete'
  end

end
