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
      expect(@new_workspace.users).must_be_kind_of Array
      expect(@new_workspace.users.first).must_be_kind_of SlackBot::User
      expect(@new_workspace.users.last).must_be_kind_of SlackBot::User
    end
    
    it "contains an array of channel instances" do
      expect(@new_workspace.channels).must_be_kind_of Array
      expect(@new_workspace.channels.first).must_be_kind_of SlackBot::Channel
      expect(@new_workspace.channels.last).must_be_kind_of SlackBot::Channel
    end
    
    it "initializes 'selected' to be nil" do
      expect(@new_workspace.selected).must_equal nil
    end
  end
  
  describe "select channel" do
    before do
      VCR.use_cassette("workspace-select-channel") do
        @new_workspace = SlackBot::Workspace.new
      end
    end
    
    it "stores a channel instance in @selected with valid channel name" do
      @new_workspace.select_channel("random")
      
      expect(@new_workspace.selected).must_be_kind_of SlackBot::Channel
    end
    
    it "stores a channel instance in @selected with valid slack_id" do
      @new_workspace.select_channel("CMURA7JFM")
      
      expect(@new_workspace.selected).must_be_kind_of SlackBot::Channel
    end
    
    it "raises argument error with invalid entry" do
      expect{@new_workspace.select_channel("blah")}.must_raise ArgumentError
    end
  end
  
  describe "select user" do
    before do
      VCR.use_cassette("workspace-select-user") do
        @new_workspace = SlackBot::Workspace.new
      end
    end
    
    it "stores a user instance in @selected with valid user name" do
      @new_workspace.select_user("idhallie")
      
      expect(@new_workspace.selected).must_be_kind_of SlackBot::User
    end
    
    it "stores a user instance in @selected with valid slack_id" do
      @new_workspace.select_user("UN69SEW21")
      
      expect(@new_workspace.selected).must_be_kind_of SlackBot::User
    end
    
    it "raises argument error with invalid entry" do
      expect{@new_workspace.select_user("blah")}.must_raise ArgumentError
    end
  end
  
  describe "show_details" do
    before do
      VCR.use_cassette("workspace-show-details") do
        @new_workspace = SlackBot::Workspace.new
      end
      @new_workspace.select_user("idhallie")
    end
    
    it "will return a string" do
      expect(@new_workspace.show_details).must_be_kind_of TablePrint::Returnable
    end
  end
end 
