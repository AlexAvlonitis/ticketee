require 'rails_helper'

feature 'Users can sign out' do

  let!(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user)
  end

  scenario 'after signed in' do
    visit '/'
    click_link 'Sign out'
    expect(page).to have_content 'Signed out successfully.'
  end

end
