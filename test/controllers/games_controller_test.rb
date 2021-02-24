require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get games_url
    assert_response :success
  end

  test "should get new" do
    get new_game_url
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post games_url, params: { game: { name: 'Test Game' } }
    end

    assert_redirected_to game_url(Game.last)
    assert_equal 'Test Game', Game.last.name
  end

  test "should show game" do
    get game_url(create(:game))
    assert_response :success
  end

  test "should get edit" do
    get edit_game_url(create(:game))
    assert_response :success
  end

  test "should update game" do
    game = create(:game, name: 'Before Edit')
    patch game_url(game), params: { game: { name: 'After Edit' } }
    game.reload

    assert_redirected_to game_url(game)
    assert_equal 'After Edit', game.name
  end

  test "should destroy game" do
    game = create(:game)

    assert_difference('Game.count', -1) do
      delete game_url(game)
    end

    assert_redirected_to games_url
  end
end
