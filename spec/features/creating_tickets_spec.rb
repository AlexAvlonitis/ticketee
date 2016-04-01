require 'rails_helper'

feature 'Users can create tickets' do

  before do
    project = FactoryGirl.create(:project, name: 'Atom')
    visit project_path(project)
    click_link 'New Ticket'
  end

  scenario 'with valid attributes' do
    fill_in "Name", with: "Open Source"
    fill_in "Description", with: "Not bad editor for the noobs"
    click_button 'Create Ticket'

    expect(page).to have_content "Ticket has been created."
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
