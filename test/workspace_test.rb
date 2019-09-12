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
      VCR.use_cassette("WT1") do
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
      VCR.use_cassette("WT1") do
        assert(ws1.all_channels.length == 3)
        index = 0
        puts ws1.all_channels.length
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
  
  it "Does show_menu work?" do
    VCR.use_cassette("WT1") do
      answer = { A: "LIST USERS", B: "LIST CHANNELS", C: "SEND MESSAGE", D: "SELECT USER", E: "SELECT CHANNEL", F: "DETAILS", Q: "QUIT" }
      returned_hash = ws1.show_menu
      assert (answer == returned_hash)
    end
  end

  describe "Does show_menu work?" do
    it "Does it return expected hash?" do
      VCR.use_cassette("WT1") do
        hash = ws1.show_menu
        assert(hash.class == Hash)
      end
    end
  end
  
  describe "Does main_menu work?" do
    it "Makes a table object?" do
      VCR.use_cassette("WT1") do
        table = ws1.main_menu(headings: ["A", "B", "C"], rows_as_hash: [["a", "b", "c"]])
        assert (table.class == Terminal::Table)
      end
    end
  end
  
  describe "Does get_all_user_details work?" do
    it "Returned object contains what we expected" do
      VCR.use_cassette("WT1") do
        results = ws1.get_all_users_details
        ap results
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
      VCR.use_cassette("WT1") do
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
      VCR.use_cassette("WT1") do
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
      VCR.use_cassette("WT1") do
        bad_args = ["", "GARBAGE", 123, Object.new]
        bad_args.each do |bad|
          expect {ws1.select_user("")}.must_raise ArgumentError
        end
      end
    end
  end
  
  describe "does select_channel work?" do
    it 'returns channel instance successfully' do
      VCR.use_cassette("WT1") do
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
      VCR.use_cassette("WT1") do
        bad_args = ["", "GARBAGE", 123, Object.new]
        bad_args.each do |bad|
          expect {ws1.select_channel("")}.must_raise ArgumentError
        end
      end
    end
  end
  
  describe "does show_all_recipients work?" do
    it 'returns enumerated table instance successfully' do
      VCR.use_cassette("WT1") do
        all_users = ws1.all_users
        result = ws1.show_all_recipients(array_of_recipient_objs: all_users, enumerate: true)
        assert(result.class == Terminal::Table)
        ### TODO: assert each cell == what it supposed to be
      end
    end
    
    it 'returns non-enumerated table instance successfully' do
      VCR.use_cassette("WT1") do
        all_users = ws1.all_users
        result = ws1.show_all_recipients(array_of_recipient_objs: all_users, enumerate: false)
        assert(result.class == Terminal::Table)
        ### TODO: assert each cell == what it supposed to be
      end
    end
  end

  describe 'main_menu works?' do
    it 'returns table instance successfully' do
      VCR.use_cassette("WT1") do
        menu = ws1.main_menu(headings: [1,2,3] , rows_as_hash: {k1: 1, k2: 2, k3: 3} )
        assert(menu.class == Terminal::Table)
        ### TODO: assert each cell == what it supposed to be
      end
    end
  end

end
