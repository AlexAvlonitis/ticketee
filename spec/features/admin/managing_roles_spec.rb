require 'rails_helper'

feature 'Admins can manage a user\'s role' do

  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }

  let!(:sublime) { FactoryGirl.create(:project, name: "sublime") }
  let!(:ie) { FactoryGirl.create(:project, name: "ie") }

  before do
    login_as(admin)
  end

  scenario 'when assigning roles to existing users' do
    visit admin_user_path(user)
    click_link 'Edit User'

    select "Viewer", from: "ie"
    select "Manager", from: "sublime"

    click_button "Update User"
    expect(page).to have_content "User has been updated"

    click_link user.email
    expect(page).to have_content "ie: Viewer"
    expect(page).to have_content "sublime: Manager"

  end

  scenario "when assigning roles to a new user" do
    visit new_admin_user_path
    fill_in "Email", with: "newuser@ticketee.com"
    fill_in "Password", with: "password"
    select "Editor", from: "Internet Explorer"
    click_button "Create User"
    click_link "newuser@ticketee.com"
    expect(page).to have_content "Internet Explorer: Editor"
    expect(page).not_to have_content "Sublime Text 3"
  end

end
