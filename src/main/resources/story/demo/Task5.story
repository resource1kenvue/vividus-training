Scenario: Login to the SauceDemo website with locked user
Given I am launching saucedemo login page
When I fill ${swagLockedUserName} and ${swagPassword} in login page and submit
When I navigate to product page 