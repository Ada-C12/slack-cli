require_relative 'test_helper.rb'

describe "##### RECIPIENT TEST #######" do

  it "does Recipient.details work?" do
    VCR.use_cassette("WT1") do
      recip1 = Recipient.new(id: "fake", name: "Fakey McFake")
      expect{recip1.details}.must_raise NotImplementedError
    end
  end

  it 'load_all work?' do
    VCR.use_cassette("RT1") do
      expect{Recipient.load_all}.must_raise NotImplementedError
    end
  end

end

