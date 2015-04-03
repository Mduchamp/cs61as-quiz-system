Given /^I am on the quiz page/ do
  visit take_students_quizzes_path
end

Given /^I am on the Requests page/ do
  visit staffs_quiz_requests_path
end

Given /^I have requested to take a quiz/ do
  steps %{
    Given I am logged in as a student
    When I press "Request quiz!"
  }
end

Given /^I have been approved to take a quiz/ do
  steps %{
    Given I have requested to take a quiz
    When I approve the quiz
    Given I am logged in as a student
  }
end

When /^I approve the quiz/ do
  steps %{
    Given I am logged in as a staff user
    And I am on the Requests page
  }
  click_button("Approve Quiz")
end

Given /^I am taking a quiz/ do
  steps %{
    Given I have been approved to take a quiz
    When I click "Begin quiz!"
  }
end

When /^I finish the quiz/ do
  check("honesty_statement")
  click_button("Submit")
end
