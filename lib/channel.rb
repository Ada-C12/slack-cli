require_relative 'recipient'
require 'httparty'
require 'dotenv'

Dotenv.load

class Channel < Recipient
  attr_reader :id, :name, :topic, :member_count

  def initialize(id, name, topic, member_count)
    super(id, name)
    @topic = topic
    @member_count = member_count
  end
end