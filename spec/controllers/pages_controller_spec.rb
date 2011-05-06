require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = 'Ruby on Rails Tutorial Sample App'
  end

  describe "GET 'home'" do
    
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    describe "when not signed in" do
      
      before(:each) do
        @user = Factory(:user)
      end
      
      it "should be successful" do
        get :home
        response.should be_success
      end
      
      it "should have the right title" do
        get :home
        response.should have_selector("title", :content => "#{@base_title} | Home")
      end
      
      it "should have the sign-up button" do
        get :home
        response.should have_selector("a", :href => "/signup", :content => "Sign up now")
      end
      
      it "should not have the user info sidebar" do
        get :home
        response.should_not have_selector("div.user_info")
      end
    end
    
    describe "when signed in" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
        other_user = Factory(:user, :email => Factory.next(:email))
        other_user.follow!(@user)
      end
      
      it "should have the user info sidebar" do
        get :home
        response.should have_selector("div.user_info")
      end
      
      it "should have the right follower/following counts" do
        get :home
        response.should have_selector("a", :href => following_user_path(@user),
                                           :content => "0 following")
        response.should have_selector("a", :href => followers_user_path(@user),
                                           :content => "1 follower")
      end
      
      describe "with one micropost" do
        
        before(:each) do
          mp1 = Factory(:micropost, :user => @user, :content => "Lorem")
        end
        
        it "should have 'micropost' in user info sidebar" do
          get :home
          response.should have_selector("span.microposts", :content => "micropost")
        end
        
        it "should not have 'microposts' in user info sidebar" do
          get :home
          response.should_not have_selector("span.microposts", :content => "microposts")
        end
      end
      
      describe "with zero microposts" do
        
        it "should have 'microposts' in user info sidebar" do
          get :home
          response.should have_selector("span.microposts", :content => "microposts")
        end
      end
      
      describe "with more than one microposts" do
        
        before(:each) do
          mp1 = Factory(:micropost, :user => @user, :content => "Lorem")
          mp2 = Factory(:micropost, :user => @user, :content => "Lorem")
        end
        
        it "should have 'microposts' in user info sidebar" do
          get :home
          response.should have_selector("span.microposts", :content => "microposts")
        end
      end
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                                    :content => @base_title + " | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                                    :content => @base_title + " | About")
    end
  end
  
  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end

    it "should have the right title" do
      get 'help'
      response.should have_selector("title",
                                    :content => @base_title + " | Help")
    end
  end
end