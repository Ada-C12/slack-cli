require_relative 'test_helper.rb'

describe "### TESTING USER ###" do
  let (:response) { User.get }
  
  it "Does User.new() work?" do
    VCR.use_cassette("UT2") do
      user1 = User.new(id: "123", name: "FakeyFake", real_name: "Fake Name")
      assert (user1.class == User)
    end
  end
  
  it "Does User.get work?" do
    VCR.use_cassette("UT2") do
      assert (response.class == HTTParty::Response)
      assert (response["ok"] == true)
    end
  end
  
  it "Does User.get_real_names work?" do
    VCR.use_cassette("UT2") do
      all_real_names = User.get_real_names
      assert(all_real_names.length == 3)
      assert(all_real_names.first == "Slackbot")
      assert(all_real_names[1] == "carolinewukaplan")
      assert(all_real_names[2] == "Emily Ball")
    end
  end
  
  it "Does User.get_names work?" do
    VCR.use_cassette("UT2") do
      all_names = User.get_names
      assert(all_names.length == 3)
      assert(all_names.first == "slackbot")
      assert(all_names[1] == "carolinewukaplan")
      assert(all_names[2] == "eaball35")
    end
  end
  
  it "Does User.get_ids work?" do
    VCR.use_cassette("UT2") do
      all_ids = User.get_ids
      assert(all_ids.length == 3)
      assert(all_ids.first == "USLACKBOT")
      assert(all_ids[1] == "UN5R2S6GL")
      assert(all_ids[2] == "UN69JD3V3")
    end
  end
  
  it "Does User.load_all work?" do
    VCR.use_cassette("UT2") do
      all_users = User.load_all
      ids = %w[USLACKBOT UN5R2S6GL UN69JD3V3]
      names = %w[slackbot carolinewukaplan eaball35]
      real_names = ["Slackbot", "carolinewukaplan", "Emily Ball"]
      all_users.each_with_index do |user, index|
        assert (user.class == User)
        assert (user.id == ids[index])
        assert (user.name == names[index])
        assert (user.real_name == real_names[index])
      end
    end
  end

  it "Does User.details work?" do
    user1 = User.new(id: "123", name: "FakeyFake", real_name: "Fake Name")
    result = user1.details
    assert (result.class == Hash)
    assert (result[:id] == "123")
    assert (result[:name] == "FakeyFake")
    assert (result[:real_name] == "Fake Name")
  end
  
end