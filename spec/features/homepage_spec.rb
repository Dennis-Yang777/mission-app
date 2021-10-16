require "rails_helper"

RSpec.describe "Home" do
  scenario "welcomes user" do
    home_page.go

    expect(page).to have_text "Welcome"
  end

  def home_page
    PageObjects::Pages::Home.new
  end
end