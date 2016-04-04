require 'rails_helper'

feature 'Users can only see appropriate links' do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:project) { FactoryGirl.create(:project) }

  context 'anonymous users' do
    scenario 'cannot see New Project link' do
      visit '/'
      expect(page).not_to have_link('New Project')
    end

    scenario 'cannot see Delete Project link' do
      visit project_path(project)
      expect(page).not_to have_link('Delete Project')
    end
  end

  context 'regular user' do

    before do
      login_as(user)
    end

    scenario 'cannot see New Project link' do
      visit '/'
      expect(page).not_to have_link('New Project')
    end

    scenario 'cannot see Delete Project link' do
      visit project_path(project)
      expect(page).not_to have_link('Delete Project')
    end
  end

  context 'admin user' do
    
    before { login_as(admin) }

    scenario 'can see New Project link' do
      visit '/'
      expect(page).to have_link('New Project')
    end

    scenario 'can see Delete Project link' do
      visit project_path(project)
      expect(page).to have_link('Delete Project')
    end
  end


end
