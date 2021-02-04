require 'rails_helper'

RSpec.describe "users new page" do
  it "has a link to sign up for new user" do
    visit root_path

    expect(page).to have_link("registration", href: registration_path)
  end

  it "can create a new user" do 
    visit registration_path
    user = User.create(email: "test5@gmail.com", password: "test5test5", is_registered?: true)

    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    fill_in "user[password_confirmation]", with: user.password
    click_on 'Register'
    expect(current_path).to eq(dashboard_user_path(user))
    expect(page).to have_content("You signed up successfully")
  end
end