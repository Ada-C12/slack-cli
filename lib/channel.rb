require_relative "recipient"

class Channel < Recipient
  attr_reader :id, :name, :details, :topic, :member_count

  def initialize(id, name, details = "", topic = "", member_count = "")
    super(id, name)
    @details = details
    @topic = topic
    @member_count = member_count
  end

  def self.load_all(url, token)
    recipients = HTTParty.get(url, query: { token: token })
    all_recipients = recipients["channels"].map do |recipient|
      recipient = new(recipient["id"], recipient["name"], recipient["info"], topic = recipient["topic"]["value"], member_count = recipient["num_members"])
    end
    return all_recipients
  end

  def load_details
    # inherits ID & Name from Recipient
    super
    return super + "\nTopic: #{@topic}" + "\nMember Count: #{@member_count}"
  end
end
