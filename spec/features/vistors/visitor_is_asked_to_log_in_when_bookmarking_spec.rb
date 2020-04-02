# frozen_string_literal: true

require 'rails_helper'

describe 'visitor visits video show page' do
  it 'cannot click on the bookmark page and is asked to log in' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    expect(page).to have_content('User must login to bookmark videos.')
    click_link 'Login'
    expect(current_path).to eq(login_path)
  end
end
