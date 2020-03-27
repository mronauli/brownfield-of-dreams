require "rails_helper"

describe "as a logged in user" do
  it "can see who it's followers on its dashboard", :vcr do
    user = create(:user, token: ENV['GITHUB_ACCESS_TOKEN_2'])
    visit login_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_on 'Log In'

    expect(current_path).to eq("/dashboard")

    within ("#github_section") do
      expect(page).to have_content("Github")
      expect(page).to have_content("Following:")
      expect(page).to have_css('#following', count: 1)

      within ("#following") do
        expect(page).to have_link("mronauli", href: "https://github.com/mronauli")
      end
    end
  end
end
