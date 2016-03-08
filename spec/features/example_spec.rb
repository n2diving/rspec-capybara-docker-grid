require 'spec_helper'

describe 'Loading the app under test' do
  it 'displays the home page' do
    visit '/'
    expect(page).to have_content 'Hello Docker World!'
  end
end