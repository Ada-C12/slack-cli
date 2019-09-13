require_relative "test_helper"

describe "user" do
  before do
    VCR.use_cassette("recipient_test") do
      @workspace = Workspace.new
      @user = @workspace.users[1]
    end
  end
  describe "initialize" do
    before do
      @test_user = User.new(id, name, details = "", username = "")
      it "creates an instance of user" do
        expect @test_user.must_be_instance_of User
      end
      it "responds to variable names" do #we got this idea from Amal & Julia
        [:id, :name, :details, :username].each do |variable|
          expect(@test_user).must_respond_to variable
        end
      end
    end
  end
  describe "load_details" do
    it "returns an accurate username" do
      expect @user.load_details.must_be_instance_of String
      expect @user.load_details.must_include "ID:"
    end
  end
end
