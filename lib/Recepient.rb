#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
Dotenv.load('../.env')
require 'awesome_print'

#CHAT_URL = "https://slack.com/api/chat.postMessage"

main if __FILE__ == $PROGRAM_NAME