# require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign up"
  end

  feature "signing up a user" do
    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in 'username', with: 'mark'
      fill_in 'password', with: 'password'
      click_on('Submit')
      expect(page).to have_http_status(:ok)
      expect(page).to have_content 'mark'
    end
  end
end

feature "logging in" do
  scenario "shows username on the homepage after login" do
    User.create(username: "mark", password: "password")
    visit new_sessions_url
    fill_in 'username', with: 'mark'
    fill_in 'password', with: 'password'
    click_on('Submit')
    expect(page).to have_http_status(:ok)
    expect(page).to have_content 'mark'
  end
end

feature "logging out" do

  scenario "begins with a logged out state" do
    visit users_url
    expect(page).to have_http_status(:ok)
    expect(page).to have_content('Log In')
  end

  scenario "doesn't show username on the homepage after logout" do
    visit new_sessions_url
    User.create(username: "mark", password: "password")
    fill_in 'username', with: 'mark'
    fill_in 'password', with: 'password'
    click_on('Submit')
    click_on('Log out')
    expect(page).not_to have_content('mark')
  end

end
