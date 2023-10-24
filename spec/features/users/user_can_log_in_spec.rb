require 'rails_helper'

describe 'Logging In' do
  it 'can log in with valid credentials' do
    user = User.create(name: 'Anna Banana', email: 'bananna@gmail.com', password: 'iamabanana')

    visit '/'

    click_on 'Log In'

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'Log In'

    expect(current_path).to eq(user_path(user.id))
  end
end