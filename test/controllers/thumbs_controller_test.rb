require "test_helper"

class ThumbsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @thumb = thumbs(:one)
  end

  test "should get index" do
    get thumbs_url
    assert_response :success
  end

  test "should get new" do
    get new_thumb_url
    assert_response :success
  end

  test "should create thumb" do
    assert_difference('Thumb.count') do
      post thumbs_url, params: { thumb: { thumbcount: @thumb.thumbcount, thumber: @thumb.thumber, user_id: @thumb.user_id } }
    end

    assert_redirected_to thumb_url(Thumb.last)
  end

  test "should show thumb" do
    get thumb_url(@thumb)
    assert_response :success
  end

  test "should get edit" do
    get edit_thumb_url(@thumb)
    assert_response :success
  end

  test "should update thumb" do
    patch thumb_url(@thumb), params: { thumb: { thumbcount: @thumb.thumbcount, thumber: @thumb.thumber, user_id: @thumb.user_id } }
    assert_redirected_to thumb_url(@thumb)
  end

  test "should destroy thumb" do
    assert_difference('Thumb.count', -1) do
      delete thumb_url(@thumb)
    end

    assert_redirected_to thumbs_url
  end
end
