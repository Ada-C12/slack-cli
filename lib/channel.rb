require_relative 'recipient'


class Channel < Recipient
  attr_reader :topic, :member_count
  
  def initialize(slack_id:, name:, topic:, member_count:)
    super(slack_id: slack_id, name: name)
    @topic = topic
    @member_count = member_count
  end
  
  
  def details
    
    
  end
  
  # Collab with Paige and Angele
  def self.list
    channels = self.get("https://slack.com/api/conversations.list")["channels"]

    channels.map do |channel|
      name = channel["name"]
      topic = channel["topic"]["value"]
      member_count = channel["num_members"]
      slack_id = channel["id"]

      Channel.new(slack_id: slack_id, name: name, topic: topic, member_count: member_count)
    end
  end
end