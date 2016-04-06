require 'rails_helper'

feature 'Users can create tickets' do

  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user)
    project = FactoryGirl.create(:project, name: 'Atom')
    assign_role!(user, :editor, project)
    visit project_path(project)
    click_link 'New Ticket'
  end

  scenario 'with valid attributes' do
    fill_in "Name", with: "Open Source"
    fill_in "Description", with: "Not bad editor for the noobs"
    click_button 'Create Ticket'

    expect(page).to have_content "Ticket has been created."
    within('#ticket') do
      expect(page).to have_content "Author: #{user.email}"
    end
  end

  scenario 'when providing invalid attributes' do
    click_button 'Create Ticket'
    expect(page).to have_content 'Name can\'t be blank'
    expect(page).to have_content 'Description can\'t be blank'
  end

  scenario 'with an invalid description' do
    fill_in "Name", with: "Atom"
    fill_in "Description", with: "hello"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Description is too short"
  end

end
