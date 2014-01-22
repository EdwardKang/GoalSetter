require 'spec_helper'

describe "the signup process" do

  it "has a new user page" do
    visit(new_user_url)
    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
    expect(page).to have_button('Create User')
  end

  describe "invalid sign up" do
    it "does not sign in blank usernames" do
      visit new_user_url
      fill_in 'Username', :with => ""
      fill_in 'Password', :with => "biscuits"
      click_on "Create User"
      expect(page).to have_content("Sign Up")
    end

    it "does not sign in blank passwords" do
      visit new_user_url
      fill_in 'Username', :with => "testing_username"
      fill_in 'Password', :with => ""
      click_on "Create User"
      expect(page).to have_content("Sign Up")
    end

    it "does not sign in short passwords" do
      visit new_user_url
      fill_in 'Username', :with => "testing_username"
      fill_in 'Password', :with => "hello"
      click_on "Create User"
      expect(page).to have_content("Sign Up")
    end

  end

  describe "signing up a user" do
    before(:each) do
      sign_up
    end

    it "shows username on the homepage after signup" do
      expect(page).to have_content("testing_username")
      expect(page).to have_content("Home")
    end

  end

end

describe "logging out" do

  it "begins with logged out state" do
    expect(page).to_not have_button("Logout")
  end

  it "doesn't show username on the user index page after logout" do
    sign_up
    click_button("Logout")
    visit(users_url)
    expect(page).to_not have_content("testing_username")
    expect(page).to_not have_button("Logout")
  end

end

describe "logging in" do
  before(:each) do
     visit new_user_url
     fill_in 'Username', :with => "testing_username"
     fill_in 'Password', :with => "biscuits"
     click_on "Create User"
   end

  it "shows username on the homepage after login" do
    click_button("Logout")
    visit(new_session_url)
    sign_in
    expect(page).to have_content("Home")
    expect(page).to have_button("Logout")
    expect(page).to have_content("testing_username")


  end

  it "doesn't sign in a invalid user" do
    click_button("Logout")
    visit(new_session_url)
    bad_sign_in
    expect(page).to_not have_content("testing_username")
    expect(page).to_not have_button("Logout")
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
    expect(page).to have_content('Invalid Username/Password Combination')
  end



end


