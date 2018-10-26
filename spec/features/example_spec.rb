require 'spec_helper'

describe 'Loading the app under test' do
  
  xit 'displays the home page' do
    puts 'Capybara test started'

    visit '/'
    expect(page).to have_content 'Hello, Docker World!'

    puts 'Capybara test finished'
    puts '¸¸♬·¯·♩¸¸♪·¯·♫¸¸Happy Dance¸¸♬·¯·♩¸¸♪·¯·♫¸¸'
  end

  it 'runs through the checkout flow' do
    puts 'start'
    puts page.html
    visit('/flowers/all/')
    first('.ui-corner-all.ui-widget.ui-button-icon-only.ui-dialog-titlebar-close').click
    first('.product-summary__media-link').click
    first('.product-details__shipping-date').click
    first('td[data-handler="selectDay"]').click
    click_button('Add To Basket')
    click_link('Checkout')
    puts 'begin checkout'
    within('#checkout_form') do
      fill_in('shipping_address[][first_name]', :with => 'Jane')
      fill_in('shipping_address[][last_name]', :with => 'Doe')
      select('Self', :from => 'shipping_address[][relationship_label]')
      first('#type_shipping_address_1').click
      first('option[value="home"]').click
      select('home', :from => '#type_shipping_address_1', visible: false)
      fill_in('shipping_address[][street]', :with => '123')
      select('Other', :from => 'order_item[5bca2a3c617070484f0000e8][occasion]')
      fill_in('order_item[5bca2a3c617070484f0000e8][message]', :with => 'Message')
      fill_in('order_item[5bca2a3c617070484f0000e8][signature]', :with => 'Signature')
      click_button('Continue')
      puts 'continue'
      fill_in('credit_card[number]', :with => '4242424242424242')
      fill_in('billing_address[name_on_card]', :with => 'Testing Testing')
      select('2021', :from => 'credit_card[year]')
      fill_in('credit_card[cvv]', :with => '123')
      fill_in('billing_address[postal_code]', :with => '90440')
      fill_in('email', :with => 'alexis@thebouqs.com')
    end
  end

end
