require_relative 'recipient'

class Channel < Recipient
  attr_reader :topic, :member_count
  
  URL = "https://slack.com/api/conversations.list"
  KEY = ENV['SLACK_API_TOKEN']
  
  def initialize(slack_id, name)
    super(slack_id, name)
    @topic = nil
    @member_count = nil
  end
  
  def self.get
    query_param = {
      token: KEY
    }
    response = HTTParty.get(URL, query: query_param )
    
    return response
    # channels = []
    # response["members"].each do |member|
    
    #   name =  member["name"]
    #   slack_id = member["id"]
    #   real_name = member["real_name"]
    #   status_text = member["status_text"]
    #   status_emoji = member["status_emoji"]
    
    #   channels << self.new(slack_id, name, real_name, status_text, status_emoji)
    
    # end
    # return channels 
    
  end
  
  private
  def details
    
  end
  
  def self.list
    
  end
  
end