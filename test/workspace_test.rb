require_relative 'test_helper.rb'

describe "### WORKSPACE ###" do
  
  let (:ws1) { Workspace.new }
  
  describe "Does Workspace.new work?" do
    
    it 'can create @all_users for new Workspace instance' do
      VCR.use_cassette("WT1") do
        assert(ws1.class == Workspace)
        assert(ws1.all_users.length == 3)
        ids = %w[USLACKBOT UN5R2S6GL UN69JD3V3]
        names = %w[slackbot carolinewukaplan eaball35]
        real_names = ["Slackbot", "carolinewukaplan", "Emily Ball"]
        index = 0
        ws1.all_users.each do |user|
          assert(user.id == ids[index])
          assert(user.name == names[index])
          assert(user.real_name == real_names[index])
          index += 1
        end
      end
    end
    
    it 'can create @all_channels for new Workspace instance' do
      VCR.use_cassette("WT1") do
        assert(ws1.all_channels.length == 3)
        ids = %w[CN5R2SQ8L CN69B7XMW CN85CG01M]
        names = %w[slack-cli general random]
        topics = ["fake topic haha", "Company-wide announcements and work-based matters", "Non-work banter and water cooler conversation"]
        member_counts = [2, 2, 2]
        index = 0
        puts ws1.all_channels.length
        ws1.all_channels.each do |channel|
          assert(channel.class == Channel)
          assert(channel.id == ids[index])
          assert(channel.name == names[index])
          assert(channel.topic == topics[index])
          assert(channel.member_count == member_counts[index])
          index += 1
        end
      end
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


  
  
  
  
  describe "Does send_msg work?" do
  end
  
  
  
  
end
