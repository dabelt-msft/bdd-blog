require "rails_helper"

RSpec.feature "User Sign in" do

  before do
    @john = User.create!(email: "john@email.com", password: "password")
  end

  scenario "with valid credentials" do
    visit "/"

    click_link "Sign in"
    fill_in "Email", with: @john.email
    fill_in "Password", with: @john.password
    click_button "Log in"

    expect(page).to have_contant("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@john.email}")

  end

  scenario "without valid credentials" do

  end
end
