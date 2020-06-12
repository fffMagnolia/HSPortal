require 'test_helper'

class InfosControllerTest < ActionDispatch::IntegrationTest
  def setup
    @owner = users(:alice)
    @non_owner = users(:marchhere)
    @alice_event = events(:alice_event)
  end

  #test "expect redirect when non-owner-user accessed" do
  #  log_in @non_owner
  #end
    
end
