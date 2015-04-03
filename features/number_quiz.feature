Feature: Number of quizzes to be graded

  As a TA or a reader,
  So that I can keep track of the number of quizzes to be graded,
  I want the page "grading" display the total number of quizzes need to be graded in "All Quizzes to grade" section.

Scenario: I have three quizzes to grade
  Given that I am on the staff dashboard
  Then I must see "Grading"
  When I press "Grading" link
  Then I must "Quizzes to Grade(3)"
  And I should see 3 quizzes below

Scenario: I don't have any quizzes to grade
  Given that I am on the staff dashboard
  When I press "Grading"
  Then I must see "Quizzes to Grade(0)"
  And I should have no quizz below
