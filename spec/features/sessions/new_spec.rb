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

  it "allows user access after sign in " do 
    user = User.create(email: "test5@gmail.com", password: "test5test5", is_registered?: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    user.authenticate(user.password)
    visit dashboard_user_path(user)
    expect(page).to have_content("Welcome #{user.email}")
  end
end