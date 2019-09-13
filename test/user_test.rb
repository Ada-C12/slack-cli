require_relative "test_helper"

describe "user" do
  before do
    VCR.use_cassette("recipient_test") do
      @workspace = Workspace.new
      @user = @workspace.users[1]
    end
  end
  describe "load_details" do
    it "returns an accurate username" do
      expect @user.load_details.must_equal nil
    end
  end
end
