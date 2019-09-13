require_relative "test_helper"


describe "Recipient" do
  before do
    @recipient = Recipient.new(slack_id: "thisisanid", name: "thisisaname")
  end
  describe "#initialize" do
    it "creates instance of Recipient" do
      VCR.use_cassette("initialize_recipient") do
        expect(@recipient).must_be_kind_of Recipient
      end
    end
    
    it "responds to variable names" do
      VCR.use_cassette("initialize_recipient") do
        [:slack_id, :name].each do |variable|
          expect(@recipient).must_respond_to variable
        end
      end
    end
    
    it "creates accurate attributes" do
      VCR.use_cassette("initialize_recipient") do
        expect(@recipient.slack_id).must_be_kind_of String
        expect(@recipient.slack_id).must_equal "thisisanid"
        
        expect(@recipient.name).must_be_kind_of String
        expect(@recipient.name).must_equal "thisisaname"
        
      end
    end  
  end
  
  describe "get" do
    it "response is not nil" do
      VCR.use_cassette("get_recipient_api") do
        response = Recipient.get("https://slack.com/api/users.list", ENV["SLACK_TOKEN"])
        expect(response).wont_be_nil
      end
    end
    
    it "raises exception if there is an error in API response" do
      VCR.use_cassette("get_recipient_api_error") do
        expect { Recipient.get("https://slack.com/api/users.list", "bad_token") }.must_raise SlackApiError
      end
    end
  end
  
  describe "#details" do
    it "raises NotImplementedError" do
      VCR.use_cassette("recipient_details_error") do
        expect{ @recipient.details }.must_raise NotImplementedError
      end
    end
  end
  
  describe "list" do
    it "raises NotImplementedError" do
      VCR.use_cassette("recipient_list_error") do
        expect{ Recipient.list }.must_raise NotImplementedError
      end
    end
  end
end
