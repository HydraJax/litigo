Given(/^I am logged in user$/) do
  step "I fill in the sign_up form with email \"#{email}\" password \"#{password}\""
  step "I should be logged in user"
end

When(/^I create the resolution$/) do
  click_on 'RESOLUTION'
  sleep 0.5
  click_on 'Edit'
  fill_in 'resolution_settlement_demand', with: 1
  fill_in 'resolution_jury_demand', with: 3
  fill_in 'resolution_resolution_amount', with: 2
  find("option[value='Settlement']").click
  click_on 'Save'
  expect(page).to have_content('Resolution successfully updated.')
end

Then(/^The resolution for user with email "(.*?)" should be saved to the db$/) do |arg1|
  u = User.where(email: arg1).first
  expect(Resolution.where(id: u.id).first.resolution_type).to eq 'Settlement'
  expect(Resolution.where(id: u.id).first.settlement_demand).to eq 1
  expect(Resolution.where(id: u.id).first.jury_demand).to eq 3
  expect(Resolution.where(id: u.id).first.resolution_amount).to eq 2
end