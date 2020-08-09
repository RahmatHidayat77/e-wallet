require "application_system_test_case"

class UserBalanceHistoriesTest < ApplicationSystemTestCase
  setup do
    @user_balance_history = user_balance_histories(:one)
  end

  test "visiting the index" do
    visit user_balance_histories_url
    assert_selector "h1", text: "User Balance Histories"
  end

  test "creating a User balance history" do
    visit user_balance_histories_url
    click_on "New User Balance History"

    fill_in "Activity", with: @user_balance_history.activity
    fill_in "Balance after", with: @user_balance_history.balance_after
    fill_in "Balance before", with: @user_balance_history.balance_before
    fill_in "User balance", with: @user_balance_history.user_balance_id
    click_on "Create User balance history"

    assert_text "User balance history was successfully created"
    click_on "Back"
  end

  test "updating a User balance history" do
    visit user_balance_histories_url
    click_on "Edit", match: :first

    fill_in "Activity", with: @user_balance_history.activity
    fill_in "Balance after", with: @user_balance_history.balance_after
    fill_in "Balance before", with: @user_balance_history.balance_before
    fill_in "User balance", with: @user_balance_history.user_balance_id
    click_on "Update User balance history"

    assert_text "User balance history was successfully updated"
    click_on "Back"
  end

  test "destroying a User balance history" do
    visit user_balance_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User balance history was successfully destroyed"
  end
end
