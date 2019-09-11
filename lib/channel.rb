require_relative 'lib_helper.rb'

class Channel < Recipient
  attr_reader :topic, :member_count
  
  def initialize(id:, name:, topic:, member_count:)
    super(id: id, name: name)
    @topic = topic
    @member_count = member_count
  end
  
  def details
    return {id: id, name: name, topic: topic , member_count: member_count}
  end
  
  
  
  def self.get
    url = "https://slack.com/api/conversations.list"
    params = { token: KEY }
    response = super(url, params)
    p response["ok"]
    sleep(0.5)
    return response
  end
  
  
  def self.get_topics
    response = (self.get)["channels"]
    all_topics = response.map do |channel_info|
      channel_info["topic"]["value"]
    end
    return all_topics
  end
  
  def self.get_names
    response = (self.get)["channels"]
    all_channel_names = response.map do |channel_info|
      channel_info["name"]
    end
    return all_channel_names
  end
  
  def self.get_member_counts
    response = (self.get)["channels"]
    member_counts = response.map do |channel_info|
      ap channel_info["num_members"]
    end
    return member_counts
  end
  
  def self.get_ids
    response = (self.get)["channels"]
    all_channel_ids = response.map do |channel_info|
      channel_info["id"]
    end
    return all_channel_ids
  end
  
  
  def self.load_all
    names = self.get_names
    ids = self.get_ids
    # member_counts = self.get_member_counts
    # topics = self.get_topics
    all_channels = []

    ap names
    ap ids
    #   ap member_counts
    #   ap topics
    
    # unless (ids.length == names.length) && (names.length == topics.length) && (topics.length == member_counts.length)
    #   raise ArgumentError, "All the arrays should have same length!"
    # end
    
    # ids.length.times do |index|
    #   ap names[index]
    #   ap ids[index]
    #   ap member_counts[index]
    #   ap topics[index]
      # new_channel = Channel.new(name: names[index], id: ids[index], member_count:[index], topic:[index])
      # ap new_channel
      # all_channels << new_channel
    # end
    
    return all_channels
  end
  
  
  
  
  
  
end