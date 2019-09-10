# require_relative 'test_helper.rb'

# describe "### TESTING USER ###" do
# let (:response) { User.get_raw_data }

# it "Does User.new() work?" do
# end

# it "Does User.get() work?" do

#   puts User.get_raw_data
# end

# it "Does get_raw_data work?" do
#   assert (response.class == HTTParty::Response)
#   assert (response["ok"] == true)
# end

# it "Does get_real_names work?" do
#   all_real_names = User.get_real_names
#   assert(all_real_names.length == 3)
#   assert(all_real_names.first == "Slackbot")
#   assert(all_real_names[1] == "carolinewukaplan")
#   assert(all_real_names[2] == "Emily Ball")
# end

# it "Does get_names work?" do
#   all_names = User.get_names
#   assert(all_names.length == 3)
#   assert(all_names.first == "slackbot")
#   assert(all_names[1] == "carolinewukaplan")
#   assert(all_names[2] == "eaball35")
# end

# it "Does get_ids work?" do
#   all_ids = User.get_ids
#   assert(all_ids.length == 3)
#   assert(all_ids.first == "USLACKBOT")
#   assert(all_ids[1] == "UN5R2S6GL")
#   assert(all_ids[2] == "UN69JD3V3")
# end

# it "Does users_in_giant_hash work?" do
#   giant_hash = User.users_in_giant_hash
#   assert (giant_hash == {"USLACKBOT"=>{:name=>"slackbot", :real_name=>"Slackbot"}, "UN5R2S6GL"=>{:name=>"carolinewukaplan", :real_name=>"carolinewukaplan"}, "UN69JD3V3"=>{:name=>"eaball35", :real_name=>"Emily Ball"}})
# end

# end