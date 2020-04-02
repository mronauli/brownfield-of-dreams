# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'as an admin user', :vcr do # rubocop:todo Metrics/BlockLength
  before(:each) do
    admin = User.create(email: 'admin@example.com', first_name: 'Bossy', last_name: 'McBosserton', password: 'password', role: :admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  end
  it 'can create new tutorials' do
    visit new_admin_tutorial_path

    title = 'Wonders of the World'
    description = 'Super meaningful tutorial about one of the wonders of the world...'
    thumbnail = 'https://i.ytimg.com/vi/VBmMU_iwe6U/hqdefault.jpg'

    fill_in 'tutorial[title]', with: title
    fill_in 'tutorial[description]', with: description
    fill_in 'tutorial[thumbnail]', with: thumbnail

    click_on 'Save'
    expect(page).to have_content('Tutorial created!')
    expect(current_path).to eq(tutorial_path(Tutorial.last))
  end

  it 'cannot create new tutorials if fields are missing' do
    visit new_admin_tutorial_path

    title = 'Wonders of the World'
    description = 'Super meaningful tutorial about the wonders of the world'
    thumbnail = ''

    fill_in 'tutorial[title]', with: title
    fill_in 'tutorial[description]', with: description
    fill_in 'tutorial[thumbnail]', with: thumbnail

    click_on 'Save'

    expect(page).to have_content('Please fill in all fields.')
    expect(current_path).to eq(new_admin_tutorial_path)
  end
end
