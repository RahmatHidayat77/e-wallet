require "application_system_test_case"

class UserBalancesTest < ApplicationSystemTestCase
  setup do
    @user_balance = user_balances(:one)
  end

  test "visiting the index" do
    visit user_balances_url
    assert_selector "h1", text: "User Balances"
  end

  test "creating a User balance" do
    visit user_balances_url
    click_on "New User Balance"

    fill_in "Balance", with: @user_balance.balance
    fill_in "Balanceachive", with: @user_balance.balanceAchive
    fill_in "Userid", with: @user_balance.userId
    click_on "Create User balance"

    assert_text "User balance was successfully created"
    click_on "Back"
  end

  test "updating a User balance" do
    visit user_balances_url
    click_on "Edit", match: :first

    fill_in "Balance", with: @user_balance.balance
    fill_in "Balanceachive", with: @user_balance.balanceAchive
    fill_in "Userid", with: @user_balance.userId
    click_on "Update User balance"

    assert_text "User balance was successfully updated"
    click_on "Back"
  end

  test "destroying a User balance" do
    visit user_balances_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User balance was successfully destroyed"
  end
end
