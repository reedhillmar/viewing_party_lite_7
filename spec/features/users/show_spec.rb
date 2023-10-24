# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rails_helper'

RSpec.feature 'User show' do
  before(:each) do
    load_test_data
    visit '/'
    click_link 'Log In'
    fill_in :email, with: @anne.email
    fill_in :password, with: @anne.password
    click_button 'Log In'
  end

  it 'has a index header', :vcr do
    visit dashboard_path

    expect(page).to have_link('Home')
    expect(page).to have_content('Viewing Party')

    click_link 'Home'

    expect(page).to have_current_path('/')
  end

  it 'has a sub header', :vcr do
    visit dashboard_path

    expect(page).to have_content("#{@anne.name}'s Dashboard")
    expect(page).to have_button('Discover Movies')

    click_button 'Discover Movies'

    expect(page).to have_current_path(discover_path)
  end

  it 'shows viewing parties', :vcr do
    visit dashboard_path

    expect(find("#party-#{@arthur.id}")).to have_link('Arthur')
    expect(find("#party-#{@arthur.id}")).to have_content(@arthur.date_formatter(@arthur.date_time))
    expect(find("#party-#{@arthur.id}")).to have_content('140 min')
    expect(find("#party-#{@arthur.id}")).to have_content(@arthur.date_formatter(@arthur.date_time))
    expect(find("#party-#{@arthur.id}")).to have_content('Hosting')

    expect(find("#party-#{@candyman.id}")).to have_content('Invited')
  end

  it 'movie title can take you to movie show page', :vcr do
    visit dashboard_path

    expect(find("#party-#{@arthur.id}")).to have_link('Arthur')

    click_link 'Arthur'

    expect(page).to have_current_path(movie_path(@arthur.movie_id))
  end

  it 'shows hosts is host', :vcr do
    visit dashboard_path

    within("#party-#{@candyman.id}") do
      expect(find('#host')).to have_content('Blair Busch')
    end
  end

  it 'lists attendees', :vcr do
    visit dashboard_path

    within("#party-#{@batman.id}") do
      expect(find('#attending')).to have_content('Anne Anderson')
      expect(find('#attending')).to have_content('Blair Busch')
      expect(find('#attending')).to_not have_content('Cindy')
    end
  end
end

# rubocop:enable Metrics/BlockLength
