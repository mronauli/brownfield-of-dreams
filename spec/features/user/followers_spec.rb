require "rails_helper"

describe "as a logged in user" do
  it "can see its followers on its dashboard", :vcr do
    user = create(:user, token: ENV['GITHUB_ACCESS_TOKEN_2'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"
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
