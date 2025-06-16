Scenario: 4.1: Launch login page for SauceDemo 
Given I am launching saucedemo login page
When I take screenshot 

Scenario: 4.2:4.3: Login to the SauceDemo with good user 
When I fill ${swagGoodUserName} and ${swagPassword} in login page and submit
When I take screenshot 
When I navigate to product page 