require 'rails_helper'

feature 'Users can edit existing tickets' do

  let(:author) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, author: author) }

  before do
    visit project_ticket_path(project, ticket)
    click_link "Edit Ticket"
  end

  scenario 'with valid attributes' do
    fill_in "Name", with: "at editor"
    click_button "Update Ticket"

    expect(page).to have_content "Ticket has been updated."
    within("#ticket h2") do
      expect(page).to have_content "at editor"
      expect(page).not_to have_content "atom"
    end
  end

end
