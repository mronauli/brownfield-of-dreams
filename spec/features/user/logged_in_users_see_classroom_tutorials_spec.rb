require "rails_helper"
RSpec.describe "as a logged in user", :vcr do
  before :each do
    mod_3_tutorial_data = {
      "title"=>"Back End Engineering - Module 3",
      "description"=>"Video content for Mod 3.",
      "thumbnail"=>"https://i.ytimg.com/vi/R5FPYQgB6Zc/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ",
      "classroom"=>true,
      "tag_list"=>["Internet", "BDD", "Ruby"],
    }
    m3_tutorial = Tutorial.create! mod_3_tutorial_data
  end
  it "can't see classroom tutorials if not logged in" do
    visit "/"
    expect(page).to_not have_content("Back End Engineering - Module 3")
  end
  it "can see classroom tutorials if logged in" do
    alex = create(:user, token: ENV['GITHUB_ACCESS_TOKEN_2'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(alex)
    visit "/"
    expect(page).to have_content("Back End Engineering - Module 3")
  end
end
