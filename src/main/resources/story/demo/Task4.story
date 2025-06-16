Scenario: 4.1: Validate baseline for login page in SauceDemo 
Given I am launching saucedemo login page
When I ESTABLISH baseline with name `testSample1`

Scenario: 4.2: Compare visual testing baseline for product page with good user 
Given I am launching saucedemo login page
When I fill ${swagGoodUserName} and ${swagPassword} in login page and submit
When I navigate to product page 
When I ESTABLISH baseline with name `testSample2`
When I COMPARE_AGAINST baseline with name `testSample2` ignoring:
|ELEMENT                                      | ACCEPTABLE_DIFF_PERCENTAGE | 
| By.xpath(.//*[@class='inventory_item_img']) | 30                         |

Scenario: 4.2: Compare visual testing baseline for product page with broken user
Given I am launching saucedemo login page
When I fill ${swagBrokenUserName} and ${swagPassword} in login page and submit
When I navigate to product page 
When I ESTABLISH baseline with name `testSample2`
When I COMPARE_AGAINST baseline with name `testSample2` ignoring:
|ELEMENT                                      | ACCEPTABLE_DIFF_PERCENTAGE | 
| By.xpath(.//*[@class='inventory_item_img']) | 30   