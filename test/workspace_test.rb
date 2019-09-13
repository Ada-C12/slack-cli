require_relative 'test_helper.rb'

describe "### WORKSPACE ###" do
  
  let (:ws1) { Workspace.new }
  let (:user_ids) { %w[USLACKBOT UN5R2S6GL UN69JD3V3] }
  let (:user_names) { %w[slackbot carolinewukaplan eaball35] }
  let (:user_real_names) { ["Slackbot", "carolinewukaplan", "Emily Ball"] }
  
  let (:channel_ids) { %w[CN5R2SQ8L CN69B7XMW CN85CG01M] }
  let (:channel_names) { %w[slack-cli general random] }
  let (:channel_topics) { ["fake topic haha", "Company-wide announcements and work-based matters", "Non-work banter and water cooler conversation"] }
  let (:channel_member_counts) { [2, 2, 2] }
  
  describe "Does Workspace.new work?" do
    
    it 'can create @all_users for new Workspace instance' do
      VCR.use_cassette("WT2") do
        assert(ws1.class == Workspace)
        assert(ws1.all_users.length == 3)
        index = 0
        ws1.all_users.each do |user|
          assert(user.id == user_ids[index])
          assert(user.name == user_names[index])
          assert(user.real_name == user_real_names[index])
          index += 1
        end
      end
    end
    
    it 'can create @all_channels for new Workspace instance' do
      VCR.use_cassette("WT2") do
        assert(ws1.all_channels.length == 3)
        index = 0
        ws1.all_channels.each do |channel|
          assert(channel.class == Channel)
          assert(channel.id == channel_ids[index])
          assert(channel.name == channel_names[index])
          assert(channel.topic == channel_topics[index])
          assert(channel.member_count == channel_member_counts[index])
          index += 1
        end
      end
    end
  end
  
  it "Does Workspace.menu_choices_hash() work?" do
    VCR.use_cassette("WT2") do
      answer = { A: "LIST USERS", B: "LIST CHANNELS", C: "SEND MESSAGE", D: "SELECT USER", E: "SELECT CHANNEL", F: "DETAILS", Q: "QUIT" }
      returned_hash = ws1.menu_choices_hash
      assert(returned_hash.class == Hash)
      assert (answer == returned_hash)
    end
  end
  
  describe "Does main_menu work?" do
    it "Makes a table object?" do
      VCR.use_cassette("WT2") do
        table = ws1.main_menu(headings: ["A", "B", "C"], rows_as_hash: [["a", "b", "c"]])
        assert (table.class == Terminal::Table)
      end
    end
  end
  
  describe "Does get_all_user_details work?" do
    it "Returned object contains what we expected" do
      VCR.use_cassette("WT2") do
        results = ws1.get_all_users_details
        assert(results.class == Array)
        
        results.each_with_index do |result, index|
          assert(result.class == Hash)
          assert(result[:id] == user_ids[index])
          assert(result[:name] == user_names[index])
          assert(result[:real_name] == user_real_names[index])
        end
      end
    end
  end
  
  
  describe "Does get_all_channel_details work?" do
    it "Returned object contains what we expected" do
      VCR.use_cassette("WT2") do
        results = ws1.get_all_channels_details
        assert(results.class == Array)
        
        results.each_with_index do |result, index|
          assert(result.class == Hash)
          assert(result[:id] == channel_ids[index])
          assert(result[:name] == channel_names[index])
          assert(result[:topic] == channel_topics[index])
          assert(result[:member_count] == 2)
        end
      end
    end
  end
  
  describe 'Does select_user work?' do
    it 'returns user instance successfully' do
      VCR.use_cassette("WT2") do
        good_args = ["EABALL35", "eAbaLL35", "eaball35"]
        good_args.each do |good|
          result = ws1.select_user(good)
          assert(result.class == User)
          assert(result.id == "UN69JD3V3")
          assert(result.real_name == "Emily Ball")
          assert(result.name == "eaball35")
        end
      end
    end
    
    it 'raises errors with bad argument' do
      VCR.use_cassette("WT2") do
        bad_args = ["", "GARBAGE", 123, Object.new]
        bad_args.each do |bad|
          expect {ws1.select_user("")}.must_raise ArgumentError
        end
      end
    end
  end
  
  describe "does select_channel work?" do
    it 'returns channel instance successfully' do
      VCR.use_cassette("WT2") do
        good_args = ["general", "GEnEral", "GENERAL"]
        good_args.each do |good|
          result = ws1.select_channel(good)
          assert(result.class == Channel)
          assert(result.id == "CN69B7XMW")
          assert(result.topic == "Company-wide announcements and work-based matters")
          assert(result.member_count == 2)
        end
      end
    end
    
    it 'raises errors with bad argument' do
      VCR.use_cassette("WT2") do
        bad_args = ["", "GARBAGE", 123, Object.new]
        bad_args.each do |bad|
          expect {ws1.select_channel("")}.must_raise ArgumentError
        end
      end
    end
  end
  
  describe 'main_menu works?' do
    it 'returns table instance successfully' do
      VCR.use_cassette("WT2") do
        menu = ws1.main_menu(headings: ["h1", "h2"] , rows_as_hash: {k1: "v1", k2: "v2", k3: "v3"} )
        assert(menu.class == Terminal::Table)
        # couldn't figure out how to test the headings...
        # menu.headings is an array of something super long, not what we think it is
        # expect(menu.headings).must_equal ["h1", "h2"] <- will fail
        assert (menu.columns.length == 2)
        assert (menu.columns[0] == [:k1, :k2, :k3])
        assert (menu.columns[1] == ["v1", "v2", "v3"])
      end
    end
  end 
  
  describe "does show_all_recipients work?" do
    it 'returns enumerated table instance successfully' do
      VCR.use_cassette("WT2") do
        all_users = ws1.all_users
        result = ws1.show_all_recipients(array_of_recipient_objs: all_users, enumerate: true)
        assert(result.class == Terminal::Table)
        assert(result.columns.length == 4)
        # couldn't figure out how to test the headings...
        # menu.headings is an array of something super long, not what we think it is
        assert(result.columns[0] == ["A", "B", "C"])
        assert(result.columns[1] == [user_ids[0], user_ids[1], user_ids[2]])
        assert(result.columns[2] == [user_names[0], user_names[1], user_names[2]])
        assert(result.columns[3] == [user_real_names[0], user_real_names[1], user_real_names[2]])
      end
    end
    
    it 'returns non-enumerated table instance successfully' do
      VCR.use_cassette("WT2") do
        all_users = ws1.all_users
        result = ws1.show_all_recipients(array_of_recipient_objs: all_users, enumerate: false)
        assert(result.class == Terminal::Table)
        assert(result.columns.length == 3)
        # couldn't figure out how to test the headings...
        # menu.headings is an array of something super long, not what we think it is
        assert(result.columns[0] == [user_ids[0], user_ids[1], user_ids[2]])
        assert(result.columns[1] == [user_names[0], user_names[1], user_names[2]])
        assert(result.columns[2] == [user_real_names[0], user_real_names[1], user_real_names[2]])
      end
    end
  end
  
  # describe "Does send_message work?" do
  
  #   it 'sends msg successfully' do
  #     VCR.use_cassette("WT2") do
  #       ws1.entity = ws1.all_users[1]
  #       response = ws1.send_message
  #       assert(response.class == HTTParty::Response)
  #     end
  #   end
  
  #   it 'raises SlackAPIError if HTTParty request failed' do
  #     VCR.use_cassette("WT2") do
  #       ws1.entity = ws1.all_users[1]
  #       response = ws1.send_message
  #       ENV["SLACK_KEY"] = "GARBAGE"
  #       expect{ws1.send_message}.must_raise SlackAPIError
  #     end
  #   end
  
  #   it 'get_msg_recipient raises SlackAPIError if no msg_recipient' do
  #     VCR.use_cassette("WT2") do
  #       assert(ws1.entity == nil)
  #       expect{ws1.get_msg_recipient}.must_raise SlackAPIError
  #       # but will get rescued by send_message, and returned as false
  #       assert(ws1.send_message == false)
  #     end
  #   end
  
  describe 'menu_action work?' do
    it 'does selecting "A" or "List Users" list the users' do
      VCR.use_cassette("WT1") do
        choices= ["A", "a", "LiSt UsErS", "List Users", "list users", "LIST USERS"]
        choices.each do |choice|
          results = ws1.menu_action(choice)
          assert(results)
        end
      end
    end
    
    it 'does selecting "B" or "List Channels" list the channels' do
      VCR.use_cassette("WT1") do
        choices= ["B", "b", "LiSt cHannElS", "List Channels", "list channels", "LIST CHANNELS"]
        choices.each do |choice|
          results = ws1.menu_action(choice)
          assert(results)
        end
      end
    end
    
    it "does selectig 'C' or 'Send Message' work?" do
      # When no user msg_recipient is selected
      VCR.use_cassette("WT1") do
        choices= ["C", "c", "SEND MESSAGE", "send message", "Send Message", "sEnD MeSsage"]
        choices.each do |choice|
          assert(ws1.menu_action(choice))
        end
      end

      # When a user msg_recipient is selected
      VCR.use_cassette("WT1") do
        ws1.entity = ws1.all_users[0]
        choices= ["C", "c", "SEND MESSAGE", "send message", "Send Message", "sEnD MeSsage"]
        choices.each do |choice|
          assert(ws1.menu_action(choice))
        end
      end

    end

    
    it 'does selecting "D" or "Send Message" send message' do
      VCR.use_cassette("WT1") do
        choices= ["C", "c", "Send Message", "seNd MesSaGe", "send message", "SEND MESSAGE"]
        choices.each do |choice|
          results = ws1.menu_action(choice)
          assert(results)
        end
      end
    end
    
    it 'does selecting "E" or "Select Channel" select channel' do
      VCR.use_cassette("WT1") do
        choices= ["E", "e", "Select Channel", "SeLEcT ChAnNeL", "select channel", "SELECT CHANNEL"]
        choices.each do |choice|
          puts "  HEY!! You have to manually enter a legit channel, so the method would return a Channel object.  So type >>> general or >>> random"
          results = ws1.menu_action(choice)
          p "it ran #{choice}"
          assert(results.class == Channel)
        end
      end
    end
    
    it 'does selecting "F" or "Details" select channel' do
      # should return false if no Channel or User selected
      VCR.use_cassette("WT1") do
        choices= ["F", "f", "Details", "DeTaILs", "details", "DETAILS"]
        choices.each do |choice|
          results = ws1.menu_action(choice)
          assert(results)
        end
      end
      
      # should return Channel/User object if Channel or User selected
      VCR.use_cassette("WT1") do
        ws1.entity = ws1.all_channels[0]
        choices= ["F", "f", "Details", "DeTaILs", "details", "DETAILS"]
        choices.each do |choice|
          results = ws1.menu_action(choice)
          assert(results)
        end
      end
    end
    
    it 'does selecting bogus menu option kick back user to menu' do
      VCR.use_cassette("WT1") do
        choices= ["G", '123', "AAA", "bb"]
        choices.each do |choice|
          results = ws1.menu_action(choice)
          refute(results)
        end
      end
    end

    it 'does selecting "Q" or "Quit" let u quit?' do
      VCR.use_cassette("WT1") do
        choices = ["Q", "q", "QUIT", "quit", "Quit"]
        choices.each do |choice|
        expect{ ws1.menu_action(choice) }.must_raise SystemExit
        end
      end
    end
    
    
    
  end      
end
