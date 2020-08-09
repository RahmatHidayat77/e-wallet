require 'test_helper'

class UserBalancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_balance = user_balances(:one)
  end

  test "should get index" do
    get user_balances_url
    assert_response :success
  end

  test "should get new" do
    get new_user_balance_url
    assert_response :success
  end

  test "should create user_balance" do
    assert_difference('UserBalance.count') do
      post user_balances_url, params: { user_balance: { balance: @user_balance.balance, balanceAchive: @user_balance.balanceAchive, userId: @user_balance.userId } }
    end

    assert_redirected_to user_balance_url(UserBalance.last)
  end

  test "should show user_balance" do
    get user_balance_url(@user_balance)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_balance_url(@user_balance)
    assert_response :success
  end

  test "should update user_balance" do
    patch user_balance_url(@user_balance), params: { user_balance: { balance: @user_balance.balance, balanceAchive: @user_balance.balanceAchive, userId: @user_balance.userId } }
    assert_redirected_to user_balance_url(@user_balance)
  end

  test "should destroy user_balance" do
    assert_difference('UserBalance.count', -1) do
      delete user_balance_url(@user_balance)
    end

    assert_redirected_to user_balances_url
  end
end
