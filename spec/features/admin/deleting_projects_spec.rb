require 'rails_helper'

feature 'Users can delete projects' do

  before do
    login_as(FactoryGirl.create(:user, :admin))
  end

  scenario 'successfully' do
    FactoryGirl.create(:project, name: 'Atom')
    
    visit '/'
    click_link 'Atom'
    click_link 'Delete Project'
    expect(page).to have_content 'Project has been deleted'
    expect(page.current_url).to eq projects_url
    expect(page).not_to have_content 'Atom'
  end

end
