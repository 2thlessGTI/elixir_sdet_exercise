defmodule FacebookLandingPage do
  use Hound.Helpers

  def url() do
    "http://facebook.com"
  end

  def first_name() do
    find_element(:name, "firstname")
  end

  def last_name() do
    find_element(:name, "lastname")
  end

  def email() do
    find_element(:name, "reg_email__")
  end

  def email_confirmation() do
    find_element(:name, "reg_email_confirmation__")
  end

  def password() do
    find_element(:xpath, "//input[@aria-label='New password']")
  end

  def bday_month(month) do
    find_element(:xpath, "//option[text()='#{month}']")
  end

  def bday_day(day) do
    find_element(:xpath, "//option[text()='#{day}']")
  end

  def bday_year(year) do
    find_element(:xpath, "//option[text()='#{year}']")
  end

  def gender(sex) do
    find_element(:xpath, "//label[text()='#{sex}']")
  end

  def sign_up() do
    find_element(:name, "websubmit")
  end

  def no_name_error() do
    find_element(:xpath, "//div[contains(text(), 'your name?')]")
  end

  def short_name_error() do
    find_element(:xpath, "//div[contains(text(), 'First or last names on Facebook')]")
  end

  def short_password_error() do
    find_element(:xpath, "//div[contains(text(), 'must be at least 6 characters long')]")
  end

  def no_email_error() do
    find_element(:xpath, "//div[contains(text(), 'use this when you log in')]")
  end

  def invalid_email_error() do
    find_element(:xpath, "//div[contains(text(), 'enter a valid')]")
  end

  def confirm_email_error() do
    find_element(:xpath, "//div[contains(text(), 'Please re-enter')]")
  end

  # this should probably go into a helpers module
  def wait_for_presence(element, current \\ 0, iterations \\ 2) do
    :timer.sleep(500)
    current = current + 1
    present = element_displayed?(element)
    cond do
      present -> true
      current == iterations -> false
      !present -> wait_for_presence(element, current)
    end
  end
  
end