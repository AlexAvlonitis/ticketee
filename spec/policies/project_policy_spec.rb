require 'rails_helper'

describe ProjectPolicy do

  context 'permissions' do
    subject { described_class.new(user, project) }

    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }

    context 'for anonymous users' do
      let(:user) { nil }

      it {should_not permit_action :show}
      it {should_not permit_action :update}
    end

    context 'for viewers of the project' do
      before { assign_role!(user, :viewer, project) }

      it {should permit_action :show}
      it {should_not permit_action :update}
    end

    context 'for editors of the project' do
      before { assign_role!(user, :editor, project) }

      it {should permit_action :show}
      it {should_not permit_action :update}
    end

    context 'for managers of the project' do
      before { assign_role!(user, :manager, project) }

      it {should permit_action :show}
      it {should permit_action :update}
    end

    context 'for managers of other project' do
      before { assign_role!(user, :manager, FactoryGirl.create(:project)) }

      it {should_not permit_action :show}
      it {should_not permit_action :update}
    end

    context 'for administrators' do
      let(:user) { FactoryGirl.create(:user, :admin) }

      it {should permit_action :show}
      it {should permit_action :update}
    end

  end

end
