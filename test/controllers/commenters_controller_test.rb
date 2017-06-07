require 'test_helper'

class CommentersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @commenter = commenters(:one)
  end

  test "should get index" do
    get commenters_url
    assert_response :success
  end

  test "should get new" do
    get new_commenter_url
    assert_response :success
  end

  test "should create commenter" do
    assert_difference('Commenter.count') do
      post commenters_url, params: { commenter: { message: @commenter.message } }
    end

    assert_redirected_to commenter_url(Commenter.last)
  end

  test "should show commenter" do
    get commenter_url(@commenter)
    assert_response :success
  end

  test "should get edit" do
    get edit_commenter_url(@commenter)
    assert_response :success
  end

  test "should update commenter" do
    patch commenter_url(@commenter), params: { commenter: { message: @commenter.message } }
    assert_redirected_to commenter_url(@commenter)
  end

  test "should destroy commenter" do
    assert_difference('Commenter.count', -1) do
      delete commenter_url(@commenter)
    end

    assert_redirected_to commenters_url
  end
end
