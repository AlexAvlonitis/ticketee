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

  scenario 'with an attachment' do
    fill_in "Name", with: "Atom"
    fill_in "Description", with: "hello asd asdasd sd"
    attach_file "File #1", "spec/fixtures/speed.txt"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."
    within('#ticket .attachments') do
      expect(page).to have_content "speed.txt"
    end
  end

  scenario 'with multiple attachments' do
    fill_in "Name", with: "Atom"
    fill_in "Description", with: "hello asd asdasd sd"
    attach_file "File #1", "spec/fixtures/speed.txt"
    attach_file "File #2", "spec/fixtures/spin.txt"
    attach_file "File #3", "spec/fixtures/gradient.txt"

    click_button 'Create Ticket'

    expect(page).to have_content "Ticket has been created."
    within('#ticket .attachments') do
      expect(page).to have_content "speed.txt"
      expect(page).to have_content "spin.txt"
      expect(page).to have_content "gradient.txt"
    end
  end

  scenario 'persisting file uploads across form displays' do
    attach_file "File #1", 'spec/fixtures/speed.txt'
    click_button "Create Ticket"

    fill_in "Name", with: "Atom"
    fill_in "Description", with: "hello asd asdasd sd"
    click_button "Create Ticket"
    within('#ticket .attachments') do
      expect(page).to have_content "speed.txt"
    end
  end



end
