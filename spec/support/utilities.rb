include ApplicationHelper

def sign_in(user)
  visit root_path
  fill_in 'Login', with: user.login
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end

def sign_out
  visit root_path
  click_link 'Sign Out'
end
