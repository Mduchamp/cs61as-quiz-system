Feature: taking a quiz

  As a student
  So that I can pass the class
  I want to take a quiz

Background: ???

Scenario: Request a quiz
  Given I am logged in as a student
  And I press "Request quiz!"
  Then I should see "You are currently requesting to take quiz"

Scenario: Taking a quiz
  Given I have been approved to take a quiz
  When I click "Begin quiz!"
  Then I should see "Question 1"
  When I click "Start!"
  Then I should see "Time left:0 minutes0 seconds"
  When I finish the quiz
  Then I should see "Welcome to the Student Dashboard!"
