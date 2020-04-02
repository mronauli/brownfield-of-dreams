require 'rails_helper'

describe "An Admin can edit a video" do
  let(:tutorial) { create(:tutorial) }
  let(:video) { create(:video) }
  let(:admin)  { create(:admin) }

  scenario "by adding a video", :js, :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit edit_admin_video_path(video)

    fill_in "video[title]", with: "How to tie your shoes."
    fill_in "video[description]", with: "#{video.description}"
    fill_in "video[video_id]", with: "#{video.video_id}"

    click_on "Update Video"

    expect(current_path).to eq(tutorial_path(video.tutorial))
    expect(page).to have_content("How to tie your shoes.")
  end
end
