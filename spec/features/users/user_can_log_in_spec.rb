require 'rails_helper'

describe 'Logging In' do
  it '(happy path) can log in with valid credentials' do
    user = User.create(name: 'Anna Banana', email: 'bananna@gmail.com', password: 'iamabanana')

    visit '/'

    click_on 'Log In'

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'Log In'

    expect(current_path).to eq(user_path(user.id))
  end

  it '(sad path) cannot log in without an email address' do
    user = User.create!(name: 'Anna Banana', email: 'bananna@gmail.com', password: 'iamabanana')

    visit login_path

    fill_in :password, with: user.password

    click_on 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Your credentials are incorrect.")
  end

  it '(sad path) cannot log in without a password' do
    user = User.create!(name: 'Anna Banana', email: 'bananna@gmail.com', password: 'iamabanana')

    visit login_path

    fill_in :email, with: user.email

    click_on 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Your credentials are incorrect.")
  end

  it '(sad path) cannot log in an unregistered email' do
    user = User.create!(name: 'Anna Banana', email: 'bananna@gmail.com', password: 'iamabanana')

    visit login_path

    fill_in :email, with: "uregistered@gmail.com"
    fill_in :password, with: user.password

    click_on 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Your credentials are incorrect.")
  end

  it '(sad path) cannot log in with the wrong password' do
    user = User.create!(name: 'Anna Banana', email: 'bananna@gmail.com', password: 'iamabanana')

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: "wrong_password"

    click_on 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Your credentials are incorrect.")
  end
end