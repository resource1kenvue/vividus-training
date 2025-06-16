Lifecycle:
Examples:
|userName|password|
|standard_user|secret_sauce|

Scenario: 4.1: 4.2: 4.3: 4.4: Validate Complete checkout process for shopping item in saucedemo website
Given I am launching saucedemo login page
When I fill <userName> and <password> in login page and submit

When I navigate to product page  
When I click on element located by `xpath(.//a[@id="<itemPageId>"])`
When I click on element located by `<addToCartButtonId>`
When I take screenshot

When I click on element located by `xpath(.//div[@id="shopping_cart_container"])`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/cart.html`
When I click on element located by `xpath(.//button[@id="checkout"])`

When I fill $firstName, $lastName and $postalCode in checkout page
When I take screenshot

When I click on element located by `xpath(.//input[@id="continue"])`
When I click on element located by `xpath(.//button[@id="finish"])`

When I save text of element located by `tagName(h2)` to scenario variable `message`
Given I initialize STORY variable `storedMessage` with value `#{loadResource(file.txt)}`
Then `#{eval(message)}` is equal to `#{eval(storedMessage)}`

Examples:
|itemName |itemPageId|addToCartButtonId|
|Sauce Labs Backpack|item_4_title_link|id(add-to-cart)| 