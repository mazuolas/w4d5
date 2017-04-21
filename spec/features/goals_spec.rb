require 'rails_helper'
feature 'goals' do

  scenario "user can add goals"  do
    mark = User.create(username: 'mark', password: 'password')

    visit new_user_goal_url(mark)
    fill_in 'goal', with: "squad goals"
    click_on('add goal')
    expect(page).to have_content("squad goals")
  end

end
