require_relative 'test_helper'
require 'pry'

describe 'class channel' do
  
  describe 'initialize' do
    let(:channel){
      Slack::Channel.new(id: 'C0G9QF9GW',
        name: 'random',
        topic: {
          "value": "Other stuff",
          "creator": "U0G9QF9C6",
          "last_set": 1449709352
        },
        member_count: 2
      )
    }
    
    it 'creates an instance of Slack::Channel' do
      expect(channel).must_be_instance_of Slack::Channel
    end
    
    it 'accurately stores id as a string' do
      expect(channel.id).must_be_instance_of String
      expect(channel.id).must_equal 'C0G9QF9GW'
    end
    
    it 'accurately stores name' do
      expect(channel.name).must_be_instance_of String
      expect(channel.name).must_equal 'random'
    end
    
    it 'accurately stores topic as a hash' do
      expect(channel.topic).must_be_instance_of Hash
      expect(channel.topic[:value]).must_equal "Other stuff"
      expect(channel.topic[:creator]).must_equal "U0G9QF9C6"
      expect(channel.topic[:last_set]).must_equal 1449709352
    end
    
    it 'accurately stores member count as an Integer' do
      expect(channel.member_count).must_be_instance_of Integer
      expect(channel.member_count).must_equal 2
    end
    
  end
  
  describe 'self.list' do  
    it "returns an array of Channel objects" do
      VCR.use_cassette("list_channels") do
        list = Slack::Channel.list
        
        expect(list).must_be_instance_of Array
        list.each do |channel|
          expect(channel).must_be_instance_of Slack::Channel
        end
      end
    end
  end   
end