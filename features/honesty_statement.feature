Feature: Honesty statement

  As a student,
  So that I can state that I did not cheat
  I want to be able to agree to the academic honesty statement


  Scenario: Honesty statement should be there
    Given I am taking a quiz
    And I should see "I assert that all the work on this quiz is my own and I have not been helped by anybody and I will not talk about the questions with anyone except course staff"

  Scenario: Honesty statement needs to be checked
    Given I am taking a quiz
    And I press "Submit"
    Then I should see "Please accept the academic honesty statement before submitting."

  Scenario: Checking the honesty statement allows student to submit quiz
    Given I am taking a quiz
    And I check "honesty_statement"
    And I press "Submit"
    Then I should see "Welcome to the Student Dashboard!"
