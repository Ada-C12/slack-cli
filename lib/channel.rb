# channel's name, topic, member count, and Slack ID

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)

    @topic = topic
    @member_count = member_count
  end

  def self.get(url, query)
    url = "https://slack.com/api/channels.list"
    query = {token: ENV['SLACK_TOKEN']}

    response = HTTParty.get(url, query: query)
    return response
  end

  def self.list
    channels_list = []
    response = Channel.get("https://slack.com/api/channels.list", {token: ENV['SLACK_TOKEN']})
    response["channels"].each do |channel|
      new_channel = Channel.new(channel["id"], channel["name"], channel["topic"], channel["members"].length)
      # binding.pry 
      channels_list << new_channel
    end
    return channels_list
  end
end
