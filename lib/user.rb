require_relative 'lib_helper.rb'
require_relative 'recipient'

class User < Recipient
  attr_reader :real_name
  
  def initialize(id:, name:, real_name:)
    super(id: id, name: name)
    @real_name = real_name
  end
  
  def details
    return {id: id, name: name, real_name: real_name}
  end
  
  def self.get
    url = "https://slack.com/api/users.list"
    params = { token: KEY }
    response = super(url, params)
    
    return response
  end
  
  def self.get_real_names
    response = (self.get)["members"]
    all_real_names = response.map do |member_info|
      member_info["real_name"]
    end
    return all_real_names
  end
  
  def self.get_names
    response = (self.get)["members"]
    all_names = response.map do |member_info|
      member_info["name"]
    end
    return all_names
  end
  
  def self.get_ids
    response = (self.get)["members"]
    all_ids = response.map do |member_info|
      member_info["id"]
    end
    return all_ids
  end
  
  def self.load_all
    real_names = self.get_real_names
    names = self.get_names
    ids = self.get_ids
    all_users = []
    
    ids.length.times do |index|
      new_user = User.new(id: ids[index], name: names[index], real_name: real_names[index])
      all_users << new_user
    end
    
    return all_users
  end
  
  
end