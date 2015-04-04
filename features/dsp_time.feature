Feature: Updated default time for (DSP) students
  As a TA for CS61AS
  So that I don't have to remember to change the quiz length
  I want to have the default time be whatever it was last time

Background:
  Given the web site is set up
  Given cs61as-ta is logged in

Scenario: using default time
  Given cs61as-st requests a quiz for lesson 1
  When I press "Requests"
  Then I should see "60 minutes"

Scenario: changing time updates next time
  Given cs61as-st requests a quiz for lesson 1
  When I press "Requests"
  Then I should see "60 minutes"
  Then I select "120 minutes" from "Select time limit"
  And I press "Approve Quiz"
  When I press "Dashboard"
  Then cs61as-st requests a quiz for lesson 2
  When I press "Requests"
  Then I should see "120 minutes"
  And I sould not see "60 minutes"