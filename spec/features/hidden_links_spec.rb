require 'rails_helper'

feature 'Users can only see appropriate links' do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) do
    FactoryGirl.create(:ticket, project: project, author: user)
  end

  context 'anonymous users' do
    scenario 'cannot see New Project link' do
      visit '/'
      expect(page).not_to have_link('New Project')
    end
  end

  context 'non-admin users (project viewers)' do

    before do
      login_as(user)
      assign_role!(user, :viewer, project)
    end

    scenario 'cannot see New Project link' do
      visit '/'
      expect(page).not_to have_link('New Project')
    end

    scenario 'cannot see New Ticket link' do
      visit project_path(project)
      expect(page).not_to have_link('New Ticket')
    end

    scenario 'cannot see New Comment form' do
      visit project_ticket_path(project, ticket)
      expect(page).not_to have_heading('New Comment')
    end

    scenario 'cannot see Delete Project link' do
      visit project_path(project)
      expect(page).not_to have_link('Delete Project')
    end

    scenario 'cannot see the Edit Ticket link' do
      visit project_ticket_path(project, ticket)
      expect(page).not_to have_link('Edit Ticket')
    end

    scenario 'cannot see the Delete Ticket link' do
      visit project_ticket_path(project, ticket)
      expect(page).not_to have_link('Delete Ticket')
    end
  end

  context 'admin users' do

    before do
      login_as(admin)
      assign_role!(admin, :viewer, project)
    end

    scenario 'can see New Project link' do
      visit '/'
      expect(page).to have_link('New Project')
    end

    scenario 'can see the New Comment form' do
      visit project_ticket_path(project, ticket)
      expect(page).to have_heading('New Comment')
    end

    scenario 'can see Delete Project link' do
      visit project_path(project)
      expect(page).to have_link('Delete Project')
    end

    scenario 'can see Delete Project link' do
      visit project_path(project)
      expect(page).to have_link('Delete Project')
    end

    scenario 'can see the Edit Ticket link' do
      visit project_ticket_path(project, ticket)
      expect(page).to have_link('Edit Ticket')
    end

    scenario 'can see the Edit Ticket link' do
      visit project_ticket_path(project, ticket)
      expect(page).to have_link('Edit Ticket')
    end

  end


end
