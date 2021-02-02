require 'rails_helper'

RSpec.describe "new user session" do
  it "has a link from root for user to login" do
    visit root_path

    expect(page).to have_link("login", href: login_path)
  end

  it "allows user to login" do 
    visit login_path

    user = User.create(email: "test5@gmail.com", password: "test5test5")

    fill_in "email", with: "test5@gmail.com"
    fill_in "password", with: "test5test5"
    click_on 'Login'
    expect(current_path).to eq(root_path)
    expect(page).to have_content("You are logged in!")
  end
end