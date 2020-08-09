require 'test_helper'

class UserBalanceHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_balance_history = user_balance_histories(:one)
  end

  test "should get index" do
    get user_balance_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_user_balance_history_url
    assert_response :success
  end

  test "should create user_balance_history" do
    assert_difference('UserBalanceHistory.count') do
      post user_balance_histories_url, params: { user_balance_history: { activity: @user_balance_history.activity, balance_after: @user_balance_history.balance_after, balance_before: @user_balance_history.balance_before, user_balance_id: @user_balance_history.user_balance_id } }
    end

    assert_redirected_to user_balance_history_url(UserBalanceHistory.last)
  end

  test "should show user_balance_history" do
    get user_balance_history_url(@user_balance_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_balance_history_url(@user_balance_history)
    assert_response :success
  end

  test "should update user_balance_history" do
    patch user_balance_history_url(@user_balance_history), params: { user_balance_history: { activity: @user_balance_history.activity, balance_after: @user_balance_history.balance_after, balance_before: @user_balance_history.balance_before, user_balance_id: @user_balance_history.user_balance_id } }
    assert_redirected_to user_balance_history_url(@user_balance_history)
  end

  test "should destroy user_balance_history" do
    assert_difference('UserBalanceHistory.count', -1) do
      delete user_balance_history_url(@user_balance_history)
    end

    assert_redirected_to user_balance_histories_url
  end
end
