require 'rails_helper'

feature 'goals' do

  subject(:mark) { mark = User.create(username: 'mark', password: 'password') }
  scenario "user can add goals"  do
    visit new_user_goal_url(mark)
    fill_in 'goal', with: "squad goals"
    click_on('add goal')
    expect(page).to have_content("squad goals")
  end

  scenario "user can mark goals as complete" do
    visit new_user_goal_url(mark)
    click_on('complete')
    expect(page).to have_content("completed")
  end
end
