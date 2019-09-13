describe "Workspace" do
  describe "#initialization" do
    before do
      VCR.use_cassette("workspace-initialize") do
        @new_workspace = SlackBot::Workspace.new
      end
    end
    
    it "creates an instance of Workspace" do
      expect(@new_workspace).must_be_kind_of SlackBot::Workspace
    end
    
    it "contains an array of user instances" do
      expect(@users).must_be_kind_of Array
      expect(@users.first).must_be_kind_of SlackBot::User
      expect(@users.last).must_be_kind_of SlackBot::User
    end
  end
end
