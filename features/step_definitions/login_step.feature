Feature: Login form
Input data to form
click submit button
 
Scenario: Sends a contact message
  Given I am a user_super
  Given I am on the user_session page
  When I fill in "user[email]" with "super@septeni-technology.jp"
  When I fill in "user[password]" with "xxxxxxxxxx"
  When I press "commit"
  Then I should be on the user_session page
