require 'spec_helper'

describe "creating cheers:" do
  describe "cheering others" do
    before(:each) do
      sign_up
      visit(new_goal_url)
      create_goal('Get a Job', 'Public')
      click_on('Logout')
      sign_up2
      click_on('testing_username')
    end

    it "there is a cheers button" do
      expect(page).to have_button('Cheer!')
    end

    it "user can create a cheer for another user" do
      click_on('Cheer!')
      expect(page).to have_content('1 Cheer!')
    end

    it "user can create multiple cheers for another user" do
      click_on('Cheer!')
      click_on('Cheer!')
      expect(page).to have_content('2 Cheers!')
    end

    it "user can create up to 5 cheers within a 24 hour window" do
      click_on('Cheer!')
      click_on('Cheer!')
      click_on('Cheer!')
      click_on('Cheer!')
      click_on('Cheer!')
      click_on('Cheer!')
      expect(page).to have_content('5 Cheers!')
      expect(page).to have_content("You're out of Cheers! :-(")
    end
  end

  describe "cheering self" do
    before(:each) do
      sign_up
      visit(new_goal_url)
      create_goal('Get a Job', 'Public')
    end

    it "user cannot cheer for his/her own goal" do
      expect(page).to_not have_button('Cheer!')
    end
  end
end










