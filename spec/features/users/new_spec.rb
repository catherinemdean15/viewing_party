require 'rails_helper'

RSpec.describe "users new page" do
  it "has a link to sign up for new user" do
    visit root_path

    expect(page).to have_link("registration", href: registration_path)
  end

  it "can create a new user" do 
    visit registration_path
    user_email = "test5@gmail.com"
    user_password = "test5test5"
    fill_in "user[email]", with: user_email
    fill_in "user[password]", with: user_password
    fill_in "user[password_confirmation]", with: user_password
    click_button 'Register'
    
    user = User.find_by(email: user_email)
    expect(current_path).to eq(dashboard_user_path(user))
    expect(page).to have_content("You signed up successfully")
  end

  it "won't allow user creation if password doesn't match" do 
    visit registration_path
    user_email = "test5@gmail.com"
    user_password = "test5test5"
    fill_in "user[email]", with: user_email
    fill_in "user[password]", with: user_password
    fill_in "user[password_confirmation]", with: 'test4test4'
    click_button 'Register'
    expect(current_path).to eq(registration_path)
    expect(page).to have_content("Passwords do not match")
  end
end
