require "rails_helper"

RSpec.describe Mission do
  it { is_expected.to validate_presence_of(:title) }
end