require "test_helper"

class GroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game = games(:one)
    @group = groups(:one)
  end

  test "should get index" do
    get game_groups_url @game
    assert_response :success
  end

  test "should get new" do
    get new_game_group_url @game
    assert_response :success
  end

  test "should create group" do
    assert_difference('Group.count') do
      post game_groups_url @game, params: { group: { group_name: @group.group_name, max_member_count: @group.max_member_count}}
    end

    assert_redirected_to game_group_url(@game, Group.last)
  end

  test "should show group" do
    get game_group_url(@game, @group)
    assert_response :success
  end

  test "should get edit" do
    # p "test:..."
    # p @group
    # p @game
    
    # get edit_game_group_url(@game, @group)
    # assert_response :success
  end

  test "should update group" do
    # p "test:..."
    # p @group
    # p @game
    # patch game_group_url(@game, @group), params: { group: { group_name: @group.group_name, max_member_count: @group.max_member_count}}
    # assert_redirected_to game_group_url(@game, @group)
  end

  test "should destroy group" do
    unless (@group.game.nil?)    
      assert_difference('Group.count', -1) do
        delete game_group_url(@group.game, @group)
      end

      assert_redirected_to game_groups_url(@game)
    end 
  end
end
