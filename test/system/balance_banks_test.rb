require "application_system_test_case"

class BalanceBanksTest < ApplicationSystemTestCase
  setup do
    @balance_bank = balance_banks(:one)
  end

  test "visiting the index" do
    visit balance_banks_url
    assert_selector "h1", text: "Balance Banks"
  end

  test "creating a Balance bank" do
    visit balance_banks_url
    click_on "New Balance Bank"

    fill_in "Balance", with: @balance_bank.balance
    fill_in "Balance achieve", with: @balance_bank.balance_achieve
    fill_in "Code", with: @balance_bank.code
    check "Enable" if @balance_bank.enable
    click_on "Create Balance bank"

    assert_text "Balance bank was successfully created"
    click_on "Back"
  end

  test "updating a Balance bank" do
    visit balance_banks_url
    click_on "Edit", match: :first

    fill_in "Balance", with: @balance_bank.balance
    fill_in "Balance achieve", with: @balance_bank.balance_achieve
    fill_in "Code", with: @balance_bank.code
    check "Enable" if @balance_bank.enable
    click_on "Update Balance bank"

    assert_text "Balance bank was successfully updated"
    click_on "Back"
  end

  test "destroying a Balance bank" do
    visit balance_banks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Balance bank was successfully destroyed"
  end
end
