require "rails_helper"

RSpec.describe "Homepage" do
  it "route root path to missions#index" do
    expect(get: "/").to route_to(controller: "missions", action: "index")
		# 對比action打到的路徑(route_to)
  end
end