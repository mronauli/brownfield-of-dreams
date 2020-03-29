require 'rails_helper'

RSpec.describe "As a user I can add friends who are in the DB but not those who are not" , :vcr do
  before :each do
    alex = create(:user, token: ENV['GITHUB_ACCESS_TOKEN_2'])
    maria = create(:user, token: ENV['GITHUB_ACCESS_TOKEN_1'])
    bob = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alex)
  end

  it "should have links to add friends next to followers/followings" do
    visit "/dashboard"
    # save_and_open_page
    within "#github_section" do
      expect(page).to have_content("Friends:")
    end

    within "#followers" do
      expect(page).to have_button("Add as Friend", count: 2)
    end

    within "#following" do
      expect(page).to have_button("Add as Friend", count: 1)
    end

    within "#following" do
      click_on("Add as Friend")
    end
  end
    #
    # expect(current_path).to eq(dashboard_path)
    #
    # within "#friends" do
    #   expect(page).to have_content("mronauli")
    # end
end
