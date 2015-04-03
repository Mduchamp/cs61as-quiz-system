Feature: Default time for DSP students

  As a TA of CS61AS
  So that I give DSP students appropriate amount of time to complete the quiz
  I want the system to remember DSP student setting and give user appropriate amount of time automatically

Scenario: Give DSP student enough time
  Given that I am a DSP student
  And I am on the Student Dashboard
  When I press "Request Quiz"
  And I click "Begin Quiz"
  Then I should see "Time left: 120 minutes"


Scenario: Remember student setting
  Given that I am a DSP student
  When I log in as a student
  And I press "Request Quiz"
  And I press "Begin Quiz"
  Then I should see "Time left: 120 minutes"