require 'rails_helper'

RSpec.describe TicketPolicy do

  context 'permissions' do
    subject { described_class.new(user, ticket) }

    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }
    let(:ticket) { FactoryGirl.create(:ticket, project: project) }

    context 'for anonymous users' do
      let(:user) { nil }

      it {should_not permit_action :show}
      it {should_not permit_action :create}
      it {should_not permit_action :update}
      it {should_not permit_action :destroy}
      it {should_not permit_action :change_state}
      it {should_not permit action :tag}
    end

    context 'for viewers of the project' do
      before { assign_role!(user, :viewer, project) }

      it {should permit_action :show}
      it {should_not permit_action :create}
      it {should_not permit_action :update}
      it {should_not permit_action :destroy}
      it {should_not permit_action :change_state}
      it {should_not permit action :tag}
    end

    context 'for editors of the project' do
      before { assign_role!(user, :editor, project) }

      it {should permit_action :show}
      it {should permit_action :create}
      it {should_not permit_action :update}
      it {should_not permit_action :destroy}
      it {should_not permit_action :change_state}
      it {should_not permit action :tag}

      context 'when the editor create the ticket' do
        before {ticket.author = user}
        it {should permit_action :update}
      end
    end

    context 'for managers of the project' do
      before { assign_role!(user, :manager, project) }

      it {should permit_action :show}
      it {should permit_action :create}
      it {should permit_action :update}
      it {should permit_action :destroy}
      it {should permit_action :change_state}
      it {should permit action :tag}
    end

    context 'for managers of other project' do
      before { assign_role!(user, :manager, FactoryGirl.create(:project)) }

      it {should_not permit_action :show}
      it {should_not permit_action :create}
      it {should_not permit_action :update}
      it {should_not permit_action :destroy}
      it {should_not permit_action :change_state}
      it {should_not permit action :tag}
    end

      let(:user) { FactoryGirl.create(:user, :admin) }

      context 'for administrators' do
      it {should permit_action :show}
      it {should permit_action :create}
      it {should permit_action :update}
      it {should permit_action :destroy}
      it {should permit_action :change_state}
      it {should permit action :tag}
    end

  end

end
