Given /^that I am on the (.*) dashboard/ do |user_type|
  visit user_session_path
  user_type == "staff"
  if user_type == "staff"
    fill_in "Login", :with=> "cs61as-ta"
  else
    fill_in "Login", :with=> "cs61as-aou"
  end
  fill_in "Password", :with=> "password"
  click_button "Sign in"
end

Then /^I must see "([^"]*)"$/ do |expected|
  if expected == "staff"
  	visit staffs_dashboard_index_path
  else
  	visit students_dashboard_path
  end
  page.should have_content(expected)
end
  
When /^I press "([^"]*)" link/ do |expected|
  visit staffs_dashboard_index_path
  page.should have_content("Grading")
end
