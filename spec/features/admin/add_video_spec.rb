# require 'rails_helper'
#
# RSpec.describe "As an admin I can add a video" do
#   it "can add a video" do
#     admin = create(:admin)
#     tutorial = create(:tutorial)
#     video_1 = create(:video, tutorial_id: tutorial.id)
#     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
#
#     visit admin_tutorial_videos_path(tutorial)
#     expect(tutorial.videos.count).to eq(1)
#
#     click_link "Add Video"
#
#     expects(current_path).to eq("/videos/new")
#
#     fill_in :name, with: "New"
#     fill_in :description, with: "Awesome video"
#
#     clicks_link "Submit"
#     expect(tutorial.videos.count).to eq(2)
#   end
# end
