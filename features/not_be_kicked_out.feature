Feature: Ability to press windows/home/alt button as well as ctrl-f

  As a student,
  So that I won't be kicked out because of pressing windows/alt/home key as well as ctrl-f on the keyboard
  I will be able to press those while taking quiz.


Scenario: I press "windows" during the quiz
  Given I am taking a quiz
  Then I should see "Question 1"
  When I press the "Windows" button
  Then I should not be kicked out
  And I should see the starter menu

Scenario: I press "alt" during the quiz
  Given I am taking a quiz
  Then I should see "Question 1"
  When I press the "alt" button
  Then I should not be kicked out
  And I should see a poped-out frame

Scenario: I press "home" during the quiz
  Given I am taking a quiz
  Then I should see "Question 1"
  When I press the "home" button
  Then I should not be kicked out
  And I should see whatever it should pop

Scenario: I press "ctrl-f" during the quiz
  Given I am taking a quiz
  Then I should see "Question 1"
  When I press the "ctrl-f" button
  Then I should not be kicked out
  And I should see a textfield
