# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'rails_helper'

RSpec.feature 'Viewing Party New' do
  before(:each) do
    load_test_data
    visit '/'
    click_link 'Log In'
    fill_in :email, with: @anne.email
    fill_in :password, with: @anne.password
    click_button 'Log In'
  end

  it 'displays form', :vcr do
    visit new_viewing_party_path(42470)

    expect(page).to have_content('Create a Movie Party for The Day of the Dolphin')
    expect(page).to have_content('Viewing Party Details')
    expect(page).to have_content('Movie Title')
    expect(page).to have_content('Duration of Party')
    expect(page).to have_field(:duration)
    expect(page).to have_content('Day')
    expect(page).to have_select('_date_2i')
    expect(page).to have_content('Start time')
    expect(page).to have_select('_time_5i')
    expect(page).to have_content('Invite Other Users')
    expect(page).to have_content('Cindy Conners (CC@aol.com)')
  end

  it 'creates viewing parties with attributes', :vcr do
    visit new_viewing_party_path(42470)

    click_button 'Create Party'

    expect(page).to have_current_path(dashboard_path)

    expect(find('#movie-42470')).to have_content('The Day of the Dolphin')
    expect(find('#movie-42470')).to have_content('104 min')
    expect(find('#movie-42470')).to have_content('Hosting')
  end

  it 'creates viewing parties with others invited', :vcr do
    visit dashboard_path

    expect(page).to_not have_content('The Day of the Dolphin')

    visit new_viewing_party_path(42470)

    find("#user-#{@cindy.id}").check 'invites_id_'

    click_button 'Create Party'

    expect(page).to have_content('The Day of the Dolphin')
    expect(find('#movie-42470')).to have_content('Hosting')

    visit '/'
    click_link 'Log Out'
    click_link 'Log In'
    fill_in :email, with: @cindy.email
    fill_in :password, with: @cindy.password
    click_button 'Log In'

    visit dashboard_path

    expect(page).to have_content('The Day of the Dolphin')
    expect(find('#movie-42470')).to have_content('Invited')

    visit '/'
    click_link 'Log Out'
    click_link 'Log In'
    fill_in :email, with: @blair.email
    fill_in :password, with: @blair.password
    click_button 'Log In'

    visit dashboard_path

    expect(page).to_not have_content('The Day of the Dolphin')
  end

  it '(sad path) will return error if date is invalid', :vcr do
    visit new_viewing_party_path(42470)

    select '2018', from: '_date_1i'

    click_button 'Create Party'

    expect(page).to have_content('Error: Date time must be greater than')
  end

  it '(sad path) will return error if duration is blank', :vcr do
    visit new_viewing_party_path(42470)

    fill_in :duration, with: 20

    click_button 'Create Party'

    expect(page).to have_content('Error: Duration must not be less than movie runtime')
  end
end

# rubocop:enable Metrics/BlockLength
