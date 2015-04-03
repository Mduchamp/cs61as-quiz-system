Feature: Number of quizzes to be graded

  As a TA or a reader,
  So that I can keep track of the number of quizzes to be graded,
  I want the page "grading" display the total number of quizzes need to be graded in "All Quizzes to grade" section.

Background:
  Given I am logged in as a staff user

Scenario: I have two quizzes to grade
  Given there are 2 quizzes to grade
  And I am on the Grading page
  Then I should see "Quizzes to Grade (2)"
  And I should see 2 quizzes below

Scenario: I don't have any quizzes to grade
  Given there are 0 quizzes to grade
  Given I am on the Grading page
  Then I should see "Quizzes to Grade (0)"
  And I should see no quiz below
>>>>>>> c0437b1230bfe11338b90100fe4017f453d5209c
