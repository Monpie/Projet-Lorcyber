require 'test_helper'

class SocieteControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get societe_index_url
    assert_response :success
  end

  test "should get show" do
    get societe_show_url
    assert_response :success
  end

end
