require 'rails_helper'

feature 'Users can comment on tickets' do

  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, author: user) }

  before do
    login_as(user)
    assign_role!(user, :manager, project)
  end

  scenario 'with valid attributes' do
    visit project_ticket_path(project, ticket)
    fill_in "Text", with: 'Added a comment!'
    click_button 'Create Comment'

    expect(page).to have_content "Comment has been created."
    within("#comments") do
      expect(page).to have_content "Added a comment!"
    end
  end

  scenario 'with valid attributes' do
    visit project_ticket_path(project, ticket)
    click_button 'Create Comment'

    expect(page).to have_content "Comment has not been created."
  end

  scenario 'when changing a tickets state' do
    FactoryGirl.create(:state, name: "Open")
    visit project_ticket_path(project, ticket)
    fill_in "Text", with: 'added another comment'
    select "Open", from: "State"

    click_button 'Create Comment'
    expect(page).to have_content "Comment has been created."
    within("#comments") do
      expect(page).to have_content("state changed to Open")
    end
  end

  scenario 'but cannot change the state without permission' do
    assign_role!(user, :editor, project)
    visit project_ticket_path(project, ticket)

    expect(page).not_to have_select "State"
  end

  scenario 'when adding a new tag on tickets' do
    visit project_ticket_path(project, ticket)
    expect(page).not_to have_content "bag"

    fill_in "Text", with: "adding the bug tag"
    fill_in "Tags", with: "bag"
    click_button 'Create Comment'

    expect(page).to have_content "Comment has been created."
    within('#ticket #tags') do
      expect(page).to have_content 'bag'
    end
  end

end
