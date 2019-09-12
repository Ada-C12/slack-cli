#lib/workspace.rb
require 'httparty'
require 'awesome_print'
require_relative "user"
require_relative "channel"

module Slack
 class  Workspace
   attr_reader :users, :channels, :selected
   def initialize
     @users = User.users_list
     @channels = Channel.channels_list
     @selected = []
   end
   def select_user(input)
     @users.each do |user|
       if user.name == input || user.id == input
         recipient = user
         @selected << recipient
       else
         raise ArgumentError.new("The provided name/id doesn't match any user")
       end
     end
   end
   def select_channel(input)
     @channels.each do |channel|
       if channel.name == input || channel.id == input
         recipient = channel
         @selected << recipient
       else
         raise ArgumentError.new("The provided name/id doesn't match any channel")
       end
     end
   end
   def show_details
     if @selected != []
       @selected.each do |recipient|
         if recipient.class == Slack::User
           puts "Name: #{recipient.name}"
           puts "Id: #{recipient.id}"
           puts "Real name: #{recipient.id}\n\n"
         else recipient.class == Slack::Channel
           topic = recipient.topic.values
           puts "Name: #{recipient.name}"
           puts "Id: #{recipient.id}"
           puts "Topic: #{recipient.topic.values[0]}, #{recipient.topic.values[1]}, #{recipient.topic.values[2]}"
           puts "Member count: #{recipient.member_count}\n\n"
         end
       end
     elsif @selected == []
       raise ArgumentError.new("No recipient is currently selected.")
     end
   end
 end
end