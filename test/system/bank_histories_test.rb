require "application_system_test_case"

class BankHistoriesTest < ApplicationSystemTestCase
  setup do
    @bank_history = bank_histories(:one)
  end

  test "visiting the index" do
    visit bank_histories_url
    assert_selector "h1", text: "Bank Histories"
  end

  test "creating a Bank history" do
    visit bank_histories_url
    click_on "New Bank History"

    fill_in "Activity", with: @bank_history.activity
    fill_in "Author", with: @bank_history.author
    fill_in "Balance after", with: @bank_history.balance_after
    fill_in "Balance bank", with: @bank_history.balance_bank_id
    fill_in "Balance before", with: @bank_history.balance_before
    fill_in "Ip", with: @bank_history.ip
    fill_in "Location", with: @bank_history.location
    fill_in "User agent", with: @bank_history.user_agent
    click_on "Create Bank history"

    assert_text "Bank history was successfully created"
    click_on "Back"
  end

  test "updating a Bank history" do
    visit bank_histories_url
    click_on "Edit", match: :first

    fill_in "Activity", with: @bank_history.activity
    fill_in "Author", with: @bank_history.author
    fill_in "Balance after", with: @bank_history.balance_after
    fill_in "Balance bank", with: @bank_history.balance_bank_id
    fill_in "Balance before", with: @bank_history.balance_before
    fill_in "Ip", with: @bank_history.ip
    fill_in "Location", with: @bank_history.location
    fill_in "User agent", with: @bank_history.user_agent
    click_on "Update Bank history"

    assert_text "Bank history was successfully updated"
    click_on "Back"
  end

  test "destroying a Bank history" do
    visit bank_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bank history was successfully destroyed"
  end
end
