class Channel < Recipient
  attr_reader :slack_id, :name, :topic, :member_count
  @@channels_list = []

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
    @@channels_list << self
  end

  def self.list
    return @@channels_list
  end
end

