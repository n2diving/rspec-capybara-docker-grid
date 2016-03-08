require 'spec_helper'

describe 'Loading the app under test' do
  it 'displays the home page' do
    puts 'Capybara test started'

    visit '/'
    expect(page).to have_content 'Hello Docker World!'

    puts 'Capybara test finished'
    puts '¸¸♬·¯·♩¸¸♪·¯·♫¸¸Happy Dance¸¸♬·¯·♩¸¸♪·¯·♫¸¸'
  end
end