require 'test_helper'

class BankHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bank_history = bank_histories(:one)
  end

  test "should get index" do
    get bank_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_bank_history_url
    assert_response :success
  end

  test "should create bank_history" do
    assert_difference('BankHistory.count') do
      post bank_histories_url, params: { bank_history: { activity: @bank_history.activity, author: @bank_history.author, balance_after: @bank_history.balance_after, balance_bank_id: @bank_history.balance_bank_id, balance_before: @bank_history.balance_before, ip: @bank_history.ip, location: @bank_history.location, user_agent: @bank_history.user_agent } }
    end

    assert_redirected_to bank_history_url(BankHistory.last)
  end

  test "should show bank_history" do
    get bank_history_url(@bank_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_bank_history_url(@bank_history)
    assert_response :success
  end

  test "should update bank_history" do
    patch bank_history_url(@bank_history), params: { bank_history: { activity: @bank_history.activity, author: @bank_history.author, balance_after: @bank_history.balance_after, balance_bank_id: @bank_history.balance_bank_id, balance_before: @bank_history.balance_before, ip: @bank_history.ip, location: @bank_history.location, user_agent: @bank_history.user_agent } }
    assert_redirected_to bank_history_url(@bank_history)
  end

  test "should destroy bank_history" do
    assert_difference('BankHistory.count', -1) do
      delete bank_history_url(@bank_history)
    end

    assert_redirected_to bank_histories_url
  end
end
