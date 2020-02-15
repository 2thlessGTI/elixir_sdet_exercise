defmodule ElixirSdetExerciseTest do
  # Import helpers
  use Hound.Helpers
  use ExUnit.Case
  alias FacebookLandingPage, as: Fblp

  # Start hound session and destroy when tests are run
  hound_session()

  @tag facebook: true
  test "empty form submit displays 'whats your name' error prompt" do
    navigate_to Fblp.url
    click(Fblp.sign_up)
    ln_described_by = attribute_value(Fblp.last_name, "aria-describedby")
    assert(element_displayed?(Fblp.no_name_error))
    assert(ln_described_by != nil)
  end

  @tag facebook: true
  test "short names display error prompt" do
    navigate_to Fblp.url
    fill_field(Fblp.first_name, "H")
    fill_field(Fblp.last_name, "S")
    fill_field(Fblp.email, "han@solo.com")
    fill_field(Fblp.password, "PrincessLeiaForever12!@")
    click(Fblp.bday_month("May"))
    click(Fblp.bday_day("25"))
    click(Fblp.bday_year("1977"))
    click(Fblp.gender("Male"))
    fill_field(Fblp.email_confirmation, "han@solo.com")
    click(Fblp.sign_up)
    assert(Fblp.wait_for_presence(Fblp.short_name_error))
  end

  @tag facebook: true
  test "empty email/number displays error prompt" do
    navigate_to Fblp.url
    fill_field(Fblp.first_name, "Han")
    fill_field(Fblp.last_name, "Solo")
    fill_field(Fblp.password, "PrincessLeiaForever")
    click(Fblp.bday_month("May"))
    click(Fblp.bday_day("25"))
    click(Fblp.bday_year("1977"))
    click(Fblp.gender("Male"))
    click(Fblp.sign_up)
    assert(element_displayed?(Fblp.no_email_error))
  end

  @tag facebook: true
  test "invalid email/number displays error prompt" do
    navigate_to Fblp.url
    fill_field(Fblp.first_name, "Han")
    fill_field(Fblp.last_name, "Solo")
    fill_field(Fblp.email, "han@solo")
    fill_field(Fblp.password, "PrincessLeiaForever")
    click(Fblp.bday_month("May"))
    click(Fblp.bday_day("25"))
    click(Fblp.bday_year("1977"))
    click(Fblp.gender("Male"))
    click(Fblp.sign_up)
    assert(element_displayed?(Fblp.invalid_email_error))
    assert(
      inner_text(Fblp.invalid_email_error) ==
      "Please enter a valid mobile number or email address."
    )

    fill_field(Fblp.email, "1234")
    click(Fblp.sign_up)
    assert(element_displayed?(Fblp.invalid_email_error))
    assert(
      inner_text(Fblp.invalid_email_error) ==
      "Please enter a valid mobile number or email address."
    )
  end

  @tag facebook: true
  test "empty email confirmation displays error prompt" do
    navigate_to Fblp.url
    fill_field(Fblp.first_name, "Han")
    fill_field(Fblp.last_name, "Solo")
    fill_field(Fblp.email, "han@solo.com")
    fill_field(Fblp.password, "PrincessLeiaForever")
    click(Fblp.bday_month("May"))
    click(Fblp.bday_day("25"))
    click(Fblp.bday_year("1977"))
    click(Fblp.gender("Male"))
    click(Fblp.sign_up)
    assert(element_displayed?(Fblp.confirm_email_error))
  end

  @tag facebook: true
  test "short password displays error prompt" do
    navigate_to Fblp.url
    fill_field(Fblp.first_name, "Han")
    fill_field(Fblp.last_name, "Solo")
    fill_field(Fblp.email, "han@solo.com")
    fill_field(Fblp.password, "Prin")
    click(Fblp.bday_month("May"))
    click(Fblp.bday_day("25"))
    click(Fblp.bday_year("1977"))
    click(Fblp.gender("Male"))
    fill_field(Fblp.email_confirmation, "han@solo.com")
    click(Fblp.sign_up)
    assert(Fblp.wait_for_presence(Fblp.short_password_error))
  end
end
