require 'spec_helper'

describe "goals features" do
  before(:each) do
    sign_up
  end

  describe "goal creation process" do
    before(:each) do
      visit(new_goal_url)
    end

    it "has a new goal page" do
      expect(page).to have_content('Create Goal')
      expect(page).to have_content('Goal')
      expect(page).to have_content('Public')
      expect(page).to have_content('Private')
      expect(page).to have_button('Create Goal')
    end

    it "creates a private goal and redirects user show page" do
      create_goal('Get a Job', 'Private')
      expect(page).to have_content('Get a Job')
      expect(page).to have_content('testing_username')
    end

    it "creates a public goal and redirects user show page" do
      create_goal('think of a goal', 'Public')
      expect(page).to have_content('think of a goal')
      expect(page).to have_content('testing_username')
    end

    it "redirects to create goal if no body" do
      create_goal('', 'Public')
      expect(page).to have_content('Create Goal')
    end

    it "redirects to create goal if no status" do
      fill_in('Goal', :with => "SHIT")
      click_on('Create Goal')
      expect(page).to have_content('Create Goal')
    end
  end

  describe "showing goals" do
    before(:each) do
      visit(new_goal_url)
      create_goal('think of a goal', 'Public')
      visit(new_goal_url)
      create_goal('think of a second goal', 'Private')
    end

    it "shows all goals for signed-in user" do
      expect(page).to have_content('think of a goal')
      expect(page).to have_content('think of a second goal')
    end

    it "shows only public goals" do
      click_button("Logout")
      sign_up2
      click_link("testing_username")
      expect(page).to have_content('think of a goal')
      expect(page).to_not have_content('think of a second goal')
    end
  end

  describe "editing goals" do
    before(:each) do
      visit(new_goal_url)
      create_goal('think of a goal', 'Public')
      click_link("Edit Goal")
    end

    it "has a goal edit page" do
      expect(page).to have_content('Edit Goal')
      expect(page).to have_content('Goal')
      expect(page).to have_content('Public')
      expect(page).to have_content('Private')
      expect(page).to have_button('Edit Goal')
    end

    it "retains current goals values" do
      find_field('Goal').value.should eq 'think of a goal'
    end

    it "updates the goal" do
      fill_in('Goal', :with => "I have to take a shit")
      click_on("Edit Goal")
      expect(page).to have_content('I have to take a shit')
    end
  end

  describe "deleting goals" do
    before(:each) do
      visit(new_goal_url)
      create_goal('think of a goal', 'Public')
      click_button("Delete")
    end

    it "deletes goal" do
      expect(page).to_not have_content('think of a goal')
    end
  end

  describe "completing goals" do
    before(:each) do
      visit(new_goal_url)
      create_goal('think of a goal', 'Public')
    end

    it "marks a goal as completed" do
      click_button("Complete")

      expect(page).to have_content('think of a goal - Completed')
    end
  end

end



























