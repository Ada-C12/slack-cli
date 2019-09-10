#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'awesome_print'
require_relative 'workspace'

Dotenv.load



def main
  
  query_param = {
    token: KEY
  }
  puts "Welcome to the Ada Slack CLI!"
  
  
  response = HTTParty.get(URL, query: query_param)
  
  puts "Thank you for using the Ada Slack CLI"
  return response
end

main if __FILE__ == $PROGRAM_NAME