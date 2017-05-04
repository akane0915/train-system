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
    fill_in('color', :with => 'Blue')
    click_button 'Add train'
    expect(page).to have_content 'Blue'
  end
end

describe 'the city creation path', {:type => :feature} do
  it 'takes the user to a page where they can create a new city' do
    visit '/'
    click_link 'Add a new city'
    expect(page).to have_content 'Welcome to the City page'
    fill_in('name', :with => 'Portland')
    click_button 'Add city'
    expect(page).to have_content 'Portland'
  end
end

describe 'the stop creation path via the train page', {:type => :feature} do
  it 'takes the user to a trains page where they can click on a train to add cities' do
    Train.new({:id => nil, :color => 'Blue'}).save
    City.new({:id => nil, :name => 'Portland'}).save
    visit '/trains'
    click_link 'Blue'
    expect(page).to have_content 'Blue Train'
    check('Portland')
    click_button 'Add cities'
    expect(page).to have_content 'Here are all the cities this train stops at: Portland'
  end
end

describe 'the stop creation path via the city page', {:type => :feature} do
  it 'takes the user to a cities page where they can select all trains which visit that city' do
    Train.new({:id => nil, :color => 'Red'}).save
    City.new({:id => nil, :name => 'Beaverton'}).save
    visit '/cities'
    click_link 'Beaverton'
    expect(page).to have_content 'Beaverton'
    check 'Red'
    click_button 'Add trains'
    expect(page).to have_content 'Here are all the trains which stop in this city: Red Train'
  end
end

describe 'the delete train path', {:type => :feature} do
  it 'lets the user delete a train' do
    test_train = Train.new({:id => nil, :color => 'Red'})
    test_train.save
    id = test_train.id
    visit "/trains/#{id}"
    expect(page).to have_content 'Red Train'
    click_button 'Delete This Train'
    expect(page).to have_no_content 'Red Train'
  end
end

describe 'the delete city path', {:type => :feature} do
  it 'lets the user delete a city' do
    test_city = City.new({:id => nil, :name => 'Portland'})
    test_city.save
    id = test_city.id
    visit "/cities/#{id}"
    expect(page).to have_content 'Portland'
    click_button 'Delete This City'
    expect(page).to have_no_content 'Portland'
  end
end
