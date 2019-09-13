require_relative 'test_helper.rb'

describe "##### RECIPIENT TEST #######" do
  let (:recip1) { Recipient.new(id: "fake", name: "Fakey McFake") }
  describe "Does Recipient.get work?" do
    it "Does it return response as expected?" do
      VCR.use_cassette("WT1") do
        url = "https://slack.com/api/conversations.list"
        response = Recipient.get(url, { token: ENV["SLACK_KEY"] })
        assert(response.class == HTTParty::Response)
        assert(response["ok"] == true)
      end
    end

    it "Does it raise error as expected?" do
      VCR.use_cassette("WT1") do
        url = "https://slack.com/api/conversations.list"
        expect{Recipient.get(url, { token: "fake" })}.must_raise SlackAPIError
      end
    end
  end

  it "Is Recipient.details blocked as it's supposed to be?" do
    VCR.use_cassette("WT1") do
      expect{recip1.details}.must_raise NotImplementedError
    end
  end

  it "Is Recipient#load_all blocked as it's supposed to be?" do
    VCR.use_cassette("RT1") do
      expect{Recipient.load_all}.must_raise NotImplementedError
    end
  end

end

