require 'spec_helper'
require './app/models/link'
Capybara.app = BookmarkManager

feature 'adding a tag' do
  scenario 'add a tag to a link' do
    visit '/links/new'
    fill_in :title, with: 'New link'
    fill_in :url, with: 'www.bbc.co.uk'
    fill_in :tags, with: 'news'
    click_button 'Save'
    link = Link.first
    expect(link.tags.map(&:name)).to include ('news')
  end
end

 feature 'adding multiple tags' do
   scenario 'add more than one tage to a link' do
     visit '/links/new'
     fill_in :title, with: 'New link'
     fill_in :url, with: 'www.bbc.co.uk'
     fill_in :tags, with: 'current affairs'
     click_button 'Save'
     link = Link.first
     expect(link.tags.map(&:name)).to include('current', 'affairs')
   end
 end
