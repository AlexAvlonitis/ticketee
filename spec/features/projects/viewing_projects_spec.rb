require 'rails_helper'

feature "Users can view projects" do

  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, name: "Sublime") }

  before do
    login_as(user)
  end

  scenario 'with the project details' do
    project = FactoryGirl.create(:project, name: "Atom")
    assign_role!(user, :viewer, project)
    visit '/'
    click_link('Atom')
    expect(page.current_url).to eq project_url(project)
  end

  scenario 'unless they don\'t have permission' do
    FactoryGirl.create(:project, name: 'hidden')
    visit '/'
    expect(page).not_to have_content 'hidden'
  end

end
