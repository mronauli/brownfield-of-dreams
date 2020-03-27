require "rails_helper"

describe "as a logged in user" do
  it "can see its followers on its dashboard", :vcr do
    user = create(:user, token: ENV['GITHUB_ACCESS_TOKEN_2'])
    visit login_path

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_on 'Log In'

    expect(current_path).to eq("/dashboard")

    within ("#github_section") do
      expect(page).to have_content("Github")
      expect(page).to have_content("Followers")
      expect(page).to have_css('#followers', count: 1)

      within ("#followers") do
        expect(page).to have_link("gregoryanderson", href: "https://github.com/gregoryanderson")
      end
    end
  end
end

# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see another section titled "Followers"
# And I should see list of all followers with their handles linking to their Github profile
