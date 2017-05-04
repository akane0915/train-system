require "capybara/rspec"
require "./app"

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'the homepage display path', {:type => :feature} do
  it 'shows a welcome message' do
    visit '/'
    expect(page).to have_content "Welcome to the Oregon Train Website!"
  end
end

describe 'the train creation path', {:type => :feature} do
  it 'takes the user to a page where they can create a new train' do
    visit '/'
    click_link 'Add a new train'
    expect(page).to have_content 'Welcome to the Train page'
  end
end

describe 'the city creation path', {:type => :feature} do
  it 'takes the user to a page where they can create a new city' do
    visit '/'
    click_link 'Add a new city'
    expect(page).to have_content 'Welcome to the City page'
  end
end
