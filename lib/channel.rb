require_relative 'lib_helper.rb'

class Channel < Recipient
  attr_reader :topic, :member_count
  
  def initialize(id:, name:, topic:, member_count:)
    # making instances in workspace.rb
    @topic = topic
    @member_count = member_count
  end
  
  def details
    return {id: id, name: name, topic: topic , member_count: member_count}
  end
  
  
  
  def self.get_raw_data
    url = "https://slack.com/api/channels.list"
    params = { token: KEY }
    response = self.get(url, params)
    p response["ok"]
    sleep(0.5)
    return response
  end
  
  def self.list
    
  end
  
  def self.get_topics
    response = (self.list)["channels"]
    all_topics = response.map do |channel_info|
      channel_info["topic"]["value"]
    end
    return all_topics
  end
  
  def self.get_names
    response = (self.list)["channels"]
    all_channel_names = response.map do |channel_info|
      channel_info["name"]
    end
    return all_channel_names
  end

  def self.get_member_counts
    response = (self.list)["channels"]
    members_counts = response.map do |channel_info|
      channel_info["members"].length
    end
    return members_counts
  end

  def self.get_ids
    response = (self.list)["channels"]
    all_channel_ids = response.map do |channel_info|
      channel_info["id"]
    end
    return all_channel_ids
  end
  
  
  
  def self.channels_in_giant_hash
    names = self.get_names
    ids = self.get_ids
    member_counts = self.get_member_counts
    topics = self.get_topics
    results = {}
    unless (ids.length == names.length) && (names.length == topics.length) && (topics.length == member_counts.length)
      raise ArgumentError, "All the arrays should have same length!"
    end
  
    ids.length.times do |index|
      results[ids[index]] = { name: names[index], topic: topics[index], member_count: member_counts[index]}
    end
    return results
  end
  
  
  
  
  
  
end