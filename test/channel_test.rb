require_relative 'test_helper.rb'


describe "### TESTING CHANNEL ###" do
  let (:response) { Channel.get }

  it "Does Channel.new work?" do
    channel = Channel.new(id: "1", name:"espn", topic:"sports", member_count: "100")
    assert(channel.class == Channel)
    assert(channel.id == "1")
    assert(channel.name == "espn")
  end

  it "Does Channel#get work?" do
    VCR.use_cassette("CT6") do
      assert (response.class == HTTParty::Response)
      assert (response["ok"] == true)
    end
  end

it "Does Channel#get_names work?" do
  VCR.use_cassette("CT6") do
    all_channel_names = Channel.get_names
    assert(all_channel_names.length == 3)
    assert(all_channel_names.first == "slack-cli")
    assert(all_channel_names[1] == "general")
    assert(all_channel_names[2] == "random")
  end
end

it "Does Channel#get_topics work?" do
  VCR.use_cassette("CT6") do
    all_channel_topics = Channel.get_topics
    assert(all_channel_topics.length == 3)
    assert(all_channel_topics.first == "fake topic haha")
    assert(all_channel_topics[1] == "Company-wide announcements and work-based matters")
    assert(all_channel_topics[2] == "Non-work banter and water cooler conversation")
  end
end

it "Does Channel#get_member_count work?" do
  VCR.use_cassette("CT6") do
    member_counts = Channel.get_member_counts
    assert(member_counts.length == 3)
    assert(member_counts.first == 2)
    assert(member_counts[1] == 2)
    assert(member_counts[2] == 2)
  end
end

it "Does Channel#get_ids work?" do
  VCR.use_cassette("CT6") do
    channel_ids = Channel.get_ids
    puts channel_ids

    assert(channel_ids.length == 3)
    assert(channel_ids.first == 'CN5R2SQ8L')
    assert(channel_ids[1] == 'CN69B7XMW')
    assert(channel_ids[2] == 'CN85CG01M')
  end
end


  it "Does Channels#load_all work?" do
    VCR.use_cassette("CT6") do
      all_channels = Channel.load_all

      # ids = %w[CN5R2SQ8L CN69B7XMW CN85CG01M]
      # names = %w[slack-cli general random]
      # topics = ["fake topic haha", "Company-wide announcements and work-based matters", "Non-work banter and water cooler conversation"]
      # all_channels.each_with_index do |channel, index|
        
      #   assert (channel.class == Channel)
      #   assert (channel.id == ids[index])
      #   assert (channel.name == names[index])
      #   assert (channel.topics == topics[index])
      # end
    
    end
  end

end