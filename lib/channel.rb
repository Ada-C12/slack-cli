require_relative 'recipient'


class Channel < Recipient
  attr_reader :topic, :member_count, :purpose
  
  def initialize(slack_id:, name:, topic:, member_count:, purpose:)
    super(slack_id: slack_id, name: name)
    @topic = topic
    @member_count = member_count
    @purpose = purpose
  end
  
  
  def details
    if Workspace.selected != nil
      Workspace.selected
      
    end
    
    # Source Citation Paige and Angele
    def self.list
      channels = self.get("https://slack.com/api/conversations.list")["channels"]
      
      channels.map do |channel|
        name = channel["name"]
        topic = channel["topic"]["value"]
        member_count = channel["num_members"]
        slack_id = channel["id"]
        purpose = channel["purpose"]
        
        Channel.new(slack_id: slack_id, name: name, topic: topic, member_count: member_count, purpose: purpose)
      end
    end
  end
  
  
  