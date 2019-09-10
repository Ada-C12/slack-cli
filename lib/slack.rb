#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'awesome_print'
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  
  url = 'https://slack.com/api/channels.list'
  query_params = 
  # TODO project
  query_params = {
  token: ENV['SLACK_TOKEN']
}
array_of_channels = []
response = HTTParty.get(url, query: query_params)
response["channels"].each do |response|
  hash_of_ids = {}
  id = response["id"]
  members = response["members"].length
  topic = response["topic"]["value"]
  name = response["name"]
  hash_of_ids["id"] = id
  hash_of_ids["members"] = members
  hash_of_ids["topic"] = topic
  hash_of_ids["name"] = name
  array_of_channels << hash_of_ids
end

ap array_of_channels
# puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME


# {"id"=>"CN5S0B30U", "name"=>"random", "is_channel"=>true, "created"=>1568073948, "is_archived"=>false, "is_general"=>false, "unlinked"=>0, "creator"=>"UMTGXDXD0", "name_normalized"=>"random", "is_shared"=>false, "is_org_shared"=>false, "is_member"=>true, "is_private"=>false, "is_mpim"=>false, "members"=>["UMTGXDXD0", "UMUS3K402", "UMW5P9DHR", "UN8GKRXK8"], 
# "topic"=>{"value"=>"Non-work banter and water cooler conversation", "creator"=>"UMTGXDXD0", "last_set"=>1568073948}, "purpose"=>{"value"=>"A place for non-work-related flimflam, faffing, hodge-podge or jibber-jabber you'd prefer to keep out of more focused work-related channels.", "creator"=>"UMTGXDXD0", "last_set"=>1568073948}, "previous_names"=>[], "num_members"=>4}