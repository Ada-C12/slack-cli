require "dotenv"

Dotenv.load

class Recipient
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.load_all(url, token)
    recipients = HTTParty.get(url, query: { token: token })
    all_recipients = recipients["members"].map do |recipient|
      recipient = new(recipient["id"], recipient["name"])
    end
    return all_recipients
  end

  def load_details
    # inherited by Channel & User
    puts "#{self.class} Details"
    puts "ID: #{self.id}"
    puts "Name: #{self.name}"
  end
end
