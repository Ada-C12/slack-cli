class Channel < Recipient
  attr_reader :topic, :member_count
  
  def initialize(topic: , member_count: , slack_id: , name: )
    super(slack_id: slack_id, name: name)
    @topic = topic
    @member_count = member_count
  end
  
  def details
    details = """
    Channel Details:
    Slack ID: #{@slack_id}
    Name: #{@name}
    Topic: #{@topic}
    Member Count: #{@member_count}
    """

    return details
  end
  
  def self.list
    response = self.get("https://slack.com/api/channels.list", ENV["SLACK_TOKEN"])
    
    # ap response
    members = response["channels"].map do |channel|
      self.new(slack_id: channel["id"], name: channel["name"], topic: channel["topic"]["value"], member_count: channel["members"].length )
    end
    return members
  end
end
