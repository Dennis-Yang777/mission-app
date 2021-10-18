require "rails_helper"

RSpec.describe "Homepage" do
  it "route root path to missions#index" do
    expect(get: "/").to route_to(controller: "homes", action: "index")
  end
end