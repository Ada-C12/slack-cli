require_relative 'test_helper.rb'

describe "### WORKSPACE ###" do
let (:ws1) { Workspace.new }
  it 'can create new workspace' do
    assert(ws1.class == Workspace)
    assert(ws1.all_users.length == 3)
    ids = %w[USLACKBOT UN5R2S6GL UN69JD3V3]
    names = %w[slackbot carolinewukaplan eaball35]
    real_names = ["Slackbot", "carolinewukaplan", "Emily Ball"]
    index = 0
    ws1.all_users.each do |user|
      assert(user.id == ids[index])
      assert(user.name == names[index])
      assert(user.real_name == real_names[index])
      index += 1
    end
  end

end
