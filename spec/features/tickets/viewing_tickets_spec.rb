require "rails_helper"

feature 'Users can view tickets' do

  before do
    atom = FactoryGirl.create(:project, name: "Atom")
    FactoryGirl.create(:ticket, project: atom,
                name: "Html autocomplete",
                description: "find the addon hunting")
    sublime = FactoryGirl.create(:project, name: "Sublime")
    FactoryGirl.create(:ticket, project: sublime,
                name: "hack it",
                description: "make it work like atom")
    visit "/"
  end

  scenario "for a given project" do
    click_link "Atom"
    expect(page).to have_content 'Html autocomplete'
    expect(page).not_to have_content "hack it"

    click_link 'Html autocomplete'
    within('#ticket h2') do
      expect(page).to have_content "Html autocomplete"
    end
    expect(page).to have_content 'find the addon hunting'
  end

end
