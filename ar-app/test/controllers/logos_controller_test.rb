require "test_helper"

class LogosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @logo = logos(:one)
  end

  test "should get index" do
    get logos_url
    assert_response :success
  end

  test "should get new" do
    get new_logo_url
    assert_response :success
  end

  test "should create logo" do
    assert_difference('Logo.count') do
      post logos_url, params: { logo: {  } }
    end

    assert_redirected_to logo_url(Logo.last)
  end

  test "should show logo" do
    get logo_url(@logo)
    assert_response :success
  end

  test "should get edit" do
    get edit_logo_url(@logo)
    assert_response :success
  end

  test "should update logo" do
    patch logo_url(@logo), params: { logo: {  } }
    assert_redirected_to logo_url(@logo)
  end

  test "should destroy logo" do
    assert_difference('Logo.count', -1) do
      delete logo_url(@logo)
    end

    assert_redirected_to logos_url
  end
end
