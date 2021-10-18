require "rails_helper"

RSpec.describe "User authentication" do
  describe "user signs in" do	
		before do
			User.create(email: "user@example.com", password: "password")
		end

		it "good credentials" do
			new_session_page.sign_in "user@example.com", "password"
	
			expect(page).to have_content "user@example.com"
		end

		it "bad credentials" do
			new_session_page.sign_in "XXX@example.com", "password"

			expect(page).not_to have_text "user@example.com"
		end
  end

	describe "user signs out" do
		it "sign_out the user" do
			user = User.create(email: "user@example.com", password: "password")
			new_session_page.sign_in "user@example.com", "password"
			navbar.sign_out user.email

			expect(page).not_to have_text "user@example.com"
		end

	end

	private
		def home_page
			PageObjects::Pages::Home.new
		end

		def navbar
			PageObjects::Application::Navbar.new
		end

		def new_session_page
			home_page.go
			navbar.sign_in
		end
end