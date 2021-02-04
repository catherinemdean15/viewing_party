require 'rails_helper'

RSpec.describe "user dashboard" do
  describe "authenticated user" do 
    before :each do 
      @user = User.create(email: "test5@gmail.com", password: "test5test5", is_registered?: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      @user.authenticate(@user.password)
    end
    it "has a friends section that has a field to add friend" do
      visit dashboard_user_path(@user)

      expect(page).to have_button("Add Friend")
      friend = User.create(email: "test4@gmail.com", password: "test4test4", is_registered?: true)
      click_button "Add Friend"
      
    end
  end
end

# As an authenticated user,
# I see a section for friends,
# In this section, there should be a text field to enter a friend's email and a button to "Add Friend"

# Scenarios:

# If I have not added any friends there should be a message. "You currently have no friends".

# If I have added friends, I should see a list of all my friends.

# Details: Users should be able to add a friend by their email address, as long as, the friend is a user of our application and exists in our database.

# Example:
# Bugs Bunny and Lola Bunny are users of our application, but Daffy Duck is not.

# When Bugs Bunny enters lola_bunny@gmail.com to add friend it will be successful and Lola should show up as Bugs Bunny's friend.
# When Bugs Bunny enters daffy_duck@gmail.com to add friend it should give an error message that the user does not exist.
# Tips: You'll want to research self-referential has_many through. Here is a good starting point to understand the concept. You will probably need to do more googling but that's part of the fun ;)

#  Write a happy path test
#  Write a sad path test