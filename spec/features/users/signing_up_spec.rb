require 'rails_helper'

feature 'Users can sign up' do

  scenario 'when providing valid details' do
    visit '/'
    click_link 'Sign Up'
    fill_in 'Email', with: "asd@asd.com"
    fill_in 'user_password', with: "asdasdasd"
    fill_in 'Password confirmation', with: "asdasdasd"
    click_button 'Sign up'
    expect(page).to have_content 'You have signed up successfully.'
  end

end
