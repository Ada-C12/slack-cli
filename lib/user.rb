require_relative "recipient"

class User < Recipient
  attr_reader :id, :name, :details, :username

  def initialize(id, name, details = "", username = "")
    super(id, name)
    @details = details
    @username = username
  end

  def self.load_all(url, token)
    recipients = HTTParty.get(url, query: { token: token })
    all_recipients = recipients["members"].map do |recipient|
      recipient = new(recipient["id"], recipient["real_name"], details = recipient["info"], username = recipient["name"])
    end
    return all_recipients
  end
end
