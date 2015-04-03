Feature: approving a quiz

  As a TA for CS61AS
  So that students can pass the class
  I want to approve student quizzes

Scenario: I don't have any quizzes to approve
  Given I am logged in as a staff user
  And I am on the Requests page
  Then I should see "Quiz Requests"
  And I should see "You don't have any quiz requests!"

Scenario: approving a quiz
  Given cs61-aa has requested a quiz
  And I am on the Staff Dashboard
  When I press "Requests"
  Then I should see "Quiz Requests"
  And I should see cs61-aa
  Then I press "Approve"
  Then I should see "Quiz Requests"
  And I should see "You don't have any quiz requests!"

Scenario: many quizzes
  Given cs61-aa and cs61as-bb have requested quizzes
  And I am on the Staff Dashboard
  When I press "Requests"
  Then I should see "Quiz Requests"
  And I should see "cs61as-aa"
  And I should see "cs61as-bb"
  Then I press "Approve" for "cs61as-aa"
  And I should see "cs61as-bb"
  And I should not see "cs61as-aa"