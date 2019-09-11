require_relative "test_helper"
describe "Workspace" do
  before do
    VCR.use_cassette("construct_workspace") do
      @workspace = Workspace.new
    end
  end
  
  describe "#initialize" do
    it "creates instance of Workspace" do
      expect(@workspace).must_be_kind_of Workspace
    end
    
    it "responds to variable names" do
      [:users, :channels, :selected].each do |variable|
        expect(@workspace).must_respond_to variable
      end
    end
    
    it "creates accurate attributes" do
      expect(@workspace.users).must_be_kind_of Array
      @workspace.users.each do |user|
        expect(user).must_be_instance_of User
      end
      
      expect(@workspace.channels).must_be_kind_of Array
      @workspace.channels.each do |channel|
        expect(channel).must_be_instance_of Channel
      end
      
      expect(@workspace.selected).must_be_nil
    end
  end
  
  xdescribe "#send_message" do
    it "can send a valid message" do
      response = @workspace.send_message("This is a message", "general")
      
      expect(response).wont_be_nil
      expect(response).must_equal true
    end
  end
end
