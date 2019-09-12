require_relative "test_helper"

describe "Workspace class" do
  before do
    VCR.use_cassette("workspace") do
      @workspace = SlackCLI::Workspace.new
    end
  end
  
  describe "Initialize Workspace" do
    it "Creates a new workspace" do
      expect(@workspace).must_be_instance_of SlackCLI::Workspace
    end
    
    it "Generates an array of users" do
      expect(@workspace.users).must_be_instance_of Array
      expect(@workspace.users.first).must_be_instance_of SlackCLI::User
    end
    
    it "Generates an array of channels" do
      expect(@workspace.channels).must_be_instance_of Array
      expect(@workspace.channels.first).must_be_instance_of SlackCLI::Channel
    end
    
    it "Initializes selected as nil" do
      expect(@workspace.selected).must_be_nil
    end
    
    it "Sets the workplace's username" do
      expect(@workspace.bot_name).must_equal "Slackbot"
    end
    
    it "Sets the workplace's icon emoji" do
      expect(@workspace.bot_avatar).must_equal "jack_o_lantern"
    end
  end
  
  describe "get_workplace_stats method" do
    it "Returns a summary with the number of users and channels" do
      actual_summary = "This workplace has 8 users and 4 channels."
      
      summary = @workspace.get_workplace_stats
      expect(summary).must_equal actual_summary
    end
  end
  
  describe "find_user method" do
    it "Finds the correct user from username" do 
      user = @workspace.find_user("slackbot")
      
      expect(user).must_be_instance_of SlackCLI::User
      expect(user.real_name).must_equal "Slackbot"
      expect(user.slack_id).must_equal "USLACKBOT"
    end
    
    it "Finds the correct user from slack ID" do 
      user = @workspace.find_user("USLACKBOT")
      
      expect(user).must_be_instance_of SlackCLI::User
      expect(user.real_name).must_equal "Slackbot"
    end
    
    it "Returns nil if user isn't found" do
      user = @workspace.find_user("goblin")
      
      expect(user).must_be_nil
    end
    
    it "Changes selected to the chosen user" do
      user = @workspace.find_user("slackbot")
      
      expect(@workspace.selected).must_equal user
    end
    
    it "Changes selected to nil if no user found" do
      @workspace.find_user("garbage")
      
      expect(@workspace.selected).must_be_nil
    end
  end
  
  describe "find_channel method" do
    it "Finds the correct channel from channel name" do 
      channel = @workspace.find_channel("random")
      
      expect(channel).must_be_instance_of SlackCLI::Channel
      expect(channel.member_count).must_equal 7
      expect(channel.slack_id).must_equal "CMUR2JTNX"
    end
    
    it "Finds the correct channel from slack ID" do 
      channel = @workspace.find_channel("CN6A88SJZ")
      
      expect(channel).must_be_instance_of SlackCLI::Channel
      expect(channel.member_count).must_equal 3
      expect(channel.name).must_equal "turkey"
    end
    
    it "Returns nil if channel isn't found" do
      channel = @workspace.find_channel("goblin")
      
      expect(channel).must_be_nil
    end
    
    it "Changes selected to the chosen channel" do
      channel = @workspace.find_channel("random")
      
      expect(@workspace.selected).must_equal channel
    end
    
    it "Changes selected to nil if no user found" do
      @workspace.find_channel("garbage")
      
      expect(@workspace.selected).must_be_nil
    end
  end  
  
  describe "send_message" do
    it "sends a message to a user" do
      VCR.use_cassette("send_message") do
        @workspace.find_user("sabrina")
        message_text = "I'm a message to a user"
        
        response = @workspace.send_message(message_text)
        
        expect(response["ok"]).must_equal true
        expect(response["message"]["text"]).must_equal message_text
      end
    end
    
    it "sends a message to a channel" do
      VCR.use_cassette("send_message") do
        @workspace.find_channel("random")
        message_text = "I'm a message to a channel"
        
        response = @workspace.send_message(message_text)
        
        expect(response["ok"]).must_equal true
        expect(response["message"]["text"]).must_equal message_text
      end
    end
    
    it "returns nil for a nonexistent user" do
      VCR.use_cassette("send_message") do
        @workspace.find_user("goblin")
        message_text = "I won't get sent to a user"
        
        response = @workspace.send_message(message_text)
        
        expect(response).must_be_nil
      end
    end
    
    it "returns nil for a nonexistent channel" do
      VCR.use_cassette("send_message") do
        @workspace.find_user("goblin")
        message_text = "I won't get sent to a channel"
        
        response = @workspace.send_message(message_text)
        
        expect(response).must_be_nil
      end
    end
  end
  
  describe "save_settings" do
    it "Saves settings in a json file" do
      @workspace.bot_name = "T-Rex"
      @workspace.bot_avatar = "t-rex"
      expected_output = {"bot_name"=>"T-Rex", "bot_avatar"=>"t-rex"}
      
      @workspace.save_settings
      file = File.read("bot-settings.json")      
      final_output = JSON.parse(file)
      
      expect(final_output).must_equal expected_output
      
      # Change settings back to default
      @workspace.bot_name = "Slackbot"
      @workspace.bot_avatar = "jack_o_lantern"
      @workspace.save_settings
      
      expect(@workspace.bot_name).must_equal "Slackbot"
      expect(@workspace.bot_avatar).must_equal "jack_o_lantern"
      
      
    end
  end
end
