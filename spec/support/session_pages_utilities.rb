module SessionPagesUtilities

  RSpec::Matchers.define :show_signin_page do
    match do |page|
      page.should have_selector('h1', text: "Sign In")
      page.should have_selector("input[name=email]")
      page.should have_selector("input[name=password]")
    end
  end

  def invalid_sign_in
    click_button "Sign In"
  end

  def valid_sign_in(athlete)
    visit signin_path
    fill_in 'email', with: athlete.email
    fill_in 'password', with: athlete.password

    click_button "Sign In"
  end

end
