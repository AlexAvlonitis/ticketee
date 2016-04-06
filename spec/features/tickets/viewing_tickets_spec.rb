require "rails_helper"

feature 'Users can view tickets' do

  before do
    author = FactoryGirl.create(:user)
    sublime = FactoryGirl.create(:project, name: "sublime")
    assign_role!(author, :viewer, sublime)
    FactoryGirl.create(:ticket, project: sublime,
                name: "Html autocomplete",
                description: "find the addon hunting",
                author: author)
    ie = FactoryGirl.create(:project, name: "ie")
    assign_role!(author, :viewer, ie)
    FactoryGirl.create(:ticket, project: ie,
                name: "hack it",
                description: "make it work like a proper browser",
                author: author)
    login_as(author)
    visit "/"
  end

  scenario "for a given project" do
    click_link "sublime"
    expect(page).to have_content 'Html autocomplete'
    expect(page).not_to have_content "hack it"

    click_link 'Html autocomplete'
    within('#ticket h2') do
      expect(page).to have_content "Html autocomplete"
    end
    expect(page).to have_content 'find the addon hunting'
  end

end
