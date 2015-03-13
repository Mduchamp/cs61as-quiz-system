Feature: Academic honesty statement
  As a student
  So that I can claim that I didn't cheat on the quiz
  I want to have a checkbox at the end of each quiz, stating: "I assert that all the work on this quiz is my own and I have not       been helped by anybody and I will not talk about the questions with anyone except course staff"

Scenario: Student should see academic honesty statement
  Given that I am on the student dashboard
  Then I must see "Welcome to the Student Dashboard!"
  And I must see "Take a quiz"
  When I press the button "Request quiz!"
  And I press "Begin Quiz"
  And I press "Start"
  Then I should see a checkbox
  And I should see "I assert that all the work on this quiz is my own and I have not been helped by anybody and I will not talk about the questions with anyone except course staff"
  
Scenario: Student must check the checkbox before submitting
  Given that I am taking a quiz
  When I answer questions
  And I press "Submit"
  Then I should see an error message