Feature: Different question types for the quizzes

  As a TA,
  I want 4 different question types (multiple choice, multiple part, true/false, what would scheme output)
  so that I can generate various quiz questions.

Scenario: I am adding a new question
  Given I am logged in as a staff user
  And I am on the Questions page
  When I try to add a new question
  Then I should see "Question type" category
  When I press "Question type"
  Then I should see "Multiple choice, Multiple part, True/False, What Would Scheme Output"

Scenario: I want to see a multiple choice question "test" created in Lession 0-1
  Given I am logged in as a staff user
  Given I am on the Questions page
  When I follow "Lesson 0-1"
  And I should see the content "test"
  And I should see "Type: multiple choice"
  Then I press "see more"
  And I should see multiple choice options in contents
