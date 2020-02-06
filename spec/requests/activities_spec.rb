# frozen_string_literal: true

require 'spec_helper'

describe 'Sunrise Manager Activities' do
  subject { page }
  before(:all) do
    @admin = FactoryGirl.create(:admin_user, email: "#{Time.now.to_i}@gmail.com")

    @post = FactoryGirl.create(:post)
    @user = FactoryGirl.create(:redactor_user)
    @event = @post.create_activity key: 'post.create', owner: @user
  end

  context 'admin' do
    before(:each) { login_as @admin }

    describe 'GET /manage' do
      before(:each) do
        visit activities_path
      end

      it 'should show page title' do
        should have_content 'Activities'
      end

      it 'should render records' do
        dom_id = ['activity', @event.id].join('_')
        should have_selector('#' + dom_id)
      end
    end
  end

  describe 'anonymous user' do
    before(:each) do
      visit activities_path
    end

    it 'should redirect to login page' do
      should have_content('Sign in')
    end
  end
end
