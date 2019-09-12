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
  end
end
