# As a registered user
# When I visit /dashboard
# And I click "Send an Invite"
# Then I should be on /invite
#
# And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
# And I click on "Send Invite"
# Then I should be on /dashboard
# And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
# Or I should see a message that says "The Github user you selected doesn't have an email address associated with their account."
require "rails_helper"

RSpec.describe "as a registered user", :vcr do
  before :each do
    @user = create(:user, token: ENV['GITHUB_ACCESS_TOKEN_1'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  context "when it enters valid github handle" do
    it "can send invite if invitee has email associated with github account" do
      visit "/dashboard"
      click_on "Send an Invite"
      expect(current_path).to eq("/invite")
      fill_in :github_handle, with: "dionew1"
      click_on "Send Invite"
      email = ActionMailer::Base.deliveries.last
      expect(email).to have_content(/#{@user.first_name} #{@user.last_name} has invited you to join brownfield-of-dreams!/)
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content "Successfully sent invite!"
    end
    it "cannot send email if invitee doesn't have email associated with github account" do
      visit "/dashboard"
      click_on "Send an Invite"
      expect(current_path).to eq("/invite")
      fill_in :github_handle, with: "jfangonilo"
      click_on "Send Invite"
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content "The Github user you selected doesn't have an email address associated with their account."
    end
  end
end
