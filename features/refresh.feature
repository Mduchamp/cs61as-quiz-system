Feature: Auto refresh when quiz is approved

  As a student
  So that I know my quiz is approved to be taken
  My page is refreshed automatically after TA's approval.


Scenario: Auto refresh the page
  When I am in the student's browser
  Given I have requested to take a quiz
  Then I should see "Your request is not approved yet!"
  When I am in the TA's browser
  And I approve the quiz
  When I am in the student's browser
  And I am on the Student Dashboard
  Then I should see "Begin quiz!"
