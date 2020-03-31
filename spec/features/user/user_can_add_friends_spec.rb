require 'rails_helper'

RSpec.describe "As a user I can add friends who are in the DB but not those who are not" , :vcr do
  before :each do
    alex = create(:user, token: ENV['GITHUB_ACCESS_TOKEN_2'], github_id: "21334556")
    maria = create(:user, token: ENV['GITHUB_ACCESS_TOKEN_1'], github_id: "55954962", first_name: "Maria", last_name: "Ronauli")
    bob = User.new(email: "example@email.com",
                   first_name: "Bob",
                   last_name: "Roberts",
                   password_digest: "password",
                   role: "default")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alex)
    visit "/dashboard"
  end

  it "should have links to add friends next to followers" do
    within "#github_section" do
     expect(page).to have_content("Friends:")
    end

    within "#followers" do
      expect(page).to have_button("Add as Friend", count: 1)
    end

    within "#following" do
      expect(page).to have_button("Add as Friend", count: 1)
    end

    within "#followers" do
      click_on("Add as Friend")
    end

    expect(current_path).to eq(dashboard_path)

    within "#friends" do
      expect(page).to have_content("Maria Ronauli")
    end
  end

  it "can add friends from following section" do
    within "#following" do
      expect(page).to have_button("Add as Friend", count: 1)
    end

    within "#following" do
      click_on("Add as Friend")
    end

    expect(current_path).to eq(dashboard_path)

    within "#friends" do
      expect(page).to have_content("Maria Ronauli")
    end
  end
end
