require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'
    click_on "Register"

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on 'Create Account'
    @user = User.first
  end

  it "shows that a user has logged in but not activated their account" do
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Logged in as #{@user.first_name} #{@user.last_name}")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")
  end
end
