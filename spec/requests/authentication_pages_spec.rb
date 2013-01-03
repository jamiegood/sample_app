require 'spec_helper'

describe "Authentication" do
  
  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    it { should have_selector('h1', text: "Sign in") }
    it { should have_selector('title', text: "Sign in") }
  end
  
  describe "signin" do
    before { visit signin_path }
    
    describe "with invalid information" do
      before { click_button "Sign in" }
      
      it { should have_selector('title', text: "Sign in") }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      
      describe "after visiting another page" do
        before { click_link "Home"}
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
  
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
    
      before do
        fill_in "Email",  with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
    
      it { should have_selector('title', text: user.name) }
      
      it { should have_link('Users', text: users_path) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link("Sign out", href: signout_path) }
      it { should_not have_link("Sign in", href: signin_path) }
      it { should have_link('Sign out') }

      it { should_not have_link('Sign in', href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
        
    end
  end
  
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Edit user')
          end
        end
      end
      
      describe "in the Users controller" do

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "visiting the following page" do
          before { visit following_user_path(user) }
          it { should have_selector('title', text: 'Sign In') }
        end

        describe "visiting the followers page" do
          before { visit followers_user_path(user) }
          it { should have_selector('title', text: 'Sign In') }
        end      
    end
    
    describe "in the microposts controller" do
      
      describe "submitting to the create actions" do
        
        before { post microposts_path }
        specify { response.should redirect_to(signin_path) }
      end
      
      describe "submitting to the destroy actions" do
        before { delete micropost_path(FactoryGirl.create(:micropost)) }
        specify { response.should redirect_to(signin_path) }
      end
      
    end
      
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }
      
      before { sign_in non_admin }
      
      describe "submitting a DELETE request to the User#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }
      end
    end
  end
end
