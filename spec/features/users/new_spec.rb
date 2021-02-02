require 'rails_helper'

RSpec.describe "users new page" do
  it "has a link to sign up for new user" do
    visit root_path

    expect(page).to have_link("registration", href: registration_path)
  end

  it "can create a new user" do 
    visit registration_path

    fill_in "user[email]", with: "test5@gmail.com"
    fill_in "user[password]", with: "test5test5"
    fill_in "user[password_confirmation]", with: "test5test5"
    click_on 'Register'
    expect(current_path).to eq(root_path)
    expect(page).to have_content("You signed up successfully")
  end
end