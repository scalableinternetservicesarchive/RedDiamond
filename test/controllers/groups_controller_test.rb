require "test_helper"

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_game_group_url(create(:game))
    assert_response :success
  end

  test "should create group" do
    game = create(:game)

    assert_difference('Group.count') do
      post game_groups_url(game), params: { group: { group_name: 'New Group', max_member_count: 100 }}
    end

    group = Group.last
    assert_redirected_to game_group_url(game, Group.last)
    assert_equal 'New Group', group.group_name
    assert_equal 100, group.max_member_count
  end

  test "should show group" do
    group = create(:group)
    get game_group_url(group.game, group)
    assert_response :success
  end

  test "should get edit" do
    group = create(:group)
    get edit_game_group_url(group.game, group)
    assert_response :success
  end

  test "should update group" do
    group = create(:group, group_name: 'Before Edit', max_member_count: 2)
    patch game_group_url(group.game, group), params: { group: { group_name: 'After Edit', max_member_count: 3 }}

    group.reload
    assert_redirected_to game_group_url(group.game, group)
    assert_equal 'After Edit', group.group_name
    assert_equal 3, group.max_member_count
  end

  test "should destroy group" do
    game = create(:game)
    group = create(:group, game: game)

    assert_difference('Group.count', -1) do
      delete game_group_url(game, group)
    end

    assert_redirected_to game_groups_url(game)
  end
end
