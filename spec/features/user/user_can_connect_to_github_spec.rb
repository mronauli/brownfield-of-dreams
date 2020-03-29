require "rails_helper"

context "as a logged in user" do
  describe "when it connects to Github", :vcr do
    it "can see its repository" do
      user = create(:user)

      visit '/'
      click_on "Sign In"

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      visit "/dashboard"
      expect(page).to_not have_content("battleship")
      mock_auth_hash
      click_button "Connect to Github"

      expect(current_path).to eq("/dashboard")
      expect(page).to have_content("battleship")
    end
  end
end
