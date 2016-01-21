module Features
  module SessionHelpers
    def sign_up_with(email, password, confirmation)
      visit new_user_registration_path
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', :with => confirmation
      click_button 'Sign up'
    end

    def signin(email, password)
      visit new_user_session_path
      within "#SignInModal" do
        fill_in 'user_email', with: email
        fill_in 'user_password', with: password
        click_button 'Se connecter'
      end
    end
  end
end
