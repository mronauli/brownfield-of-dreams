# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'As a visitor' do # rubocop:todo Metrics/BlockLength
  before :each do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'
    visit '/'
    click_on 'Register'
    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password
    click_on 'Create Account'
    @user = User.first
  end

  it 'shows that a user has logged in but not activated their account' do
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Logged in as #{@user.first_name} #{@user.last_name}")
    expect(page).to have_content('This account has not yet been activated. Please check your email.')
  end

  it 'can click the link in email to confirm account' do
    email = ActionMailer::Base.deliveries.last
    expect(email).to have_content(/Registration Confirmation/)
    expect(email).to have_content("#{@user.first_name} #{@user.last_name}")
    mail = email.to_s
    path_regex = %r{(?:"https?\://.*?)(/.*?)(?:")}
    path = mail.match(path_regex)[1]
    visit(path)
    expect(page).to have_content('Thank you! Your account is now activated.')
    visit dashboard_path
    expect(page).to have_content('Status: Active')
  end
end
