require 'rails_helper'

RSpec.describe "welcome page" do
  it "has a welcome message and brief description of the application" do
    visit root_path

    expect(page).to have_content("Welcome to the Viewing Party")
    expect(page).to have_content("Viewing Party is a web application that allows you to organize a viewing party with your friends!")
  end
end