require 'rails_helper'

feature 'Users can sign in' do

  let!(:user) { FactoryGirl.create(:user) }

  scenario 'when providing valid details' do
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content "Signed in as #{user.email}"
  end

end
