# channel's name, topic, member count, and Slack ID

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(name, topic, member_count, slack_id)
    super(name, slack_id)

    @topic = topic
    @member_count = member_count
  end
end
