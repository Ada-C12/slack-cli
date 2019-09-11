require_relative "test_helper"

describe "Channel" do
  describe "#initialize" do
    before do
      @channel = Channel.new(topic: "cool_things", member_count: 5, slack_id: "4321", name: "ThisIsAPlace")
    end
    it "creates instance of Channel" do
      VCR.use_cassette("initialize_channel") do
        expect(@channel).must_be_kind_of Channel
      end
    end
    
    it "responds to variable names" do
      VCR.use_cassette("initialize_channel") do
        [:topic, :member_count, :slack_id, :name].each do |variable|
          expect(@channel).must_respond_to variable
        end
      end
    end
    
    it "creates accurate attributes" do
      VCR.use_cassette("initialize_channel") do
        expect(@channel.topic).must_be_kind_of String
        expect(@channel.topic).must_equal "cool_things"
        
        expect(@channel.member_count).must_be_kind_of Integer
        expect(@channel.member_count).must_equal 5
        
        expect(@channel.slack_id).must_be_kind_of String
        expect(@channel.slack_id).must_equal "4321"
        
        expect(@channel.name).must_be_kind_of String
        expect(@channel.name).must_equal "ThisIsAPlace"
      end
    end
  end
  
  describe "list method" do 
    it "self.list returns an array of Channels" do 
      VCR.use_cassette("list_channels") do 
        results = Channel.list 
        expect(results).must_be_instance_of Array 
        results.each do |result|
          expect(result).must_be_instance_of Channel
        end 
      end 
    end 
    
    it "returns accurate information" do
      VCR.use_cassette("list_channels") do 
        results = Channel.list
        
        info = [
          {slack_id: "CN5RT17J8", name: "random", topic: "Non-work banter and water cooler conversation", member_count: 2},
          {slack_id: "CN862L6AK", name: "general", topic: "Company-wide announcements and work-based matters", member_count: 2},
          {slack_id: "CN862LB8F", name: "awesome-slack-cli-design-activity", topic: "Discussing the amazing things that are happening here.", member_count: 2},
        ]
        
        results.each_with_index do |result, index|
          expect(result.slack_id).must_be_kind_of String
          expect(result.slack_id).must_equal info[index][:slack_id]
          
          expect(result.name).must_be_kind_of String
          expect(result.name).must_equal info[index][:name]
          
          expect(result.topic).must_be_kind_of String
          expect(result.topic).must_equal info[index][:topic]

          expect(result.member_count).must_be_kind_of Integer
          expect(result.member_count).must_equal info[index][:member_count]
        end
      end
    end
  end
end
