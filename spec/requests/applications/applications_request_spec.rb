require 'spec_helper'

feature 'Adding applications' do
  context 'in application form' do
    background do
      visit '/oauth/applications/new'
    end

    scenario 'adding a valid app' do
      fill_in 'Name', :with => 'My Application'
      fill_in 'Redirect uri', :with => 'http://example.com'
      click_button 'Submit'
      i_should_see 'Application created'
      i_should_see 'My Application'
    end

    scenario 'adding invalid app' do
      click_button 'Submit'
      i_should_see 'Whoops! Check your form for possible errors'
    end
  end
end

feature 'Listing applications' do
  background do
    Factory :application, :name => 'Oauth Dude'
    Factory :application, :name => 'Awesome App'
  end

  scenario 'application list' do
    visit '/oauth/applications'
    i_should_see 'Awesome App'
    i_should_see 'Oauth Dude'
  end
end

feature 'Show application' do
  let :app do
    Factory :application, :name => 'Just another oauth app'
  end

  scenario 'visiting application page' do
    visit "/oauth/applications/#{app.id}"
    i_should_see 'Just another oauth app'
  end
end

feature 'Edit application' do
  let :app do
    Factory :application, :name => 'OMG my app'
  end

  background do
    visit "/oauth/applications/#{app.id}/edit"
  end

  scenario 'updating a valid app' do
    fill_in :name, :with => "Serious app"
    click_button 'Submit'
    i_should_see "Application updated"
    i_should_see "Serious app"
    i_should_not_see "OMG my app"
  end

  scenario 'updating an invalid app' do
    fill_in :name, :with => ""
    click_button 'Submit'
    i_should_see 'Whoops! Check your form for possible errors'
  end
end
