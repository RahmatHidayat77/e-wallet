require 'test_helper'

class BalanceBanksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @balance_bank = balance_banks(:one)
  end

  test "should get index" do
    get balance_banks_url
    assert_response :success
  end

  test "should get new" do
    get new_balance_bank_url
    assert_response :success
  end

  test "should create balance_bank" do
    assert_difference('BalanceBank.count') do
      post balance_banks_url, params: { balance_bank: { balance: @balance_bank.balance, balance_achieve: @balance_bank.balance_achieve, code: @balance_bank.code, enable: @balance_bank.enable } }
    end

    assert_redirected_to balance_bank_url(BalanceBank.last)
  end

  test "should show balance_bank" do
    get balance_bank_url(@balance_bank)
    assert_response :success
  end

  test "should get edit" do
    get edit_balance_bank_url(@balance_bank)
    assert_response :success
  end

  test "should update balance_bank" do
    patch balance_bank_url(@balance_bank), params: { balance_bank: { balance: @balance_bank.balance, balance_achieve: @balance_bank.balance_achieve, code: @balance_bank.code, enable: @balance_bank.enable } }
    assert_redirected_to balance_bank_url(@balance_bank)
  end

  test "should destroy balance_bank" do
    assert_difference('BalanceBank.count', -1) do
      delete balance_bank_url(@balance_bank)
    end

    assert_redirected_to balance_banks_url
  end
end
