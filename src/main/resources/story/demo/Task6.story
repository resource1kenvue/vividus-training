Lifecycle:
Examples:
|userName|password|
|standard_user|secret_sauce|
|performance_glitch_user|secret_sauce|

Scenario: 4.1: 4.2: Validate items added to the cart with different users
Given I am launching saucedemo login page
When I fill <userName> and <password> in login page and submit
When I navigate to product page  
When I click on element located by `xpath(.//a[@id="<itemPageId>"])`
When I click on element located by `<addToCartButtonId>`

When I save text of element located by `xpath(.//div[@data-test="inventory-item-name"])` to scenario variable `item`
Then `#{eval(item)}` is equal to `#{eval('<itemName>')}`
When I take screenshot

Examples:
|itemName |itemPageId|addToCartButtonId|
|Sauce Labs Backpack|item_4_title_link|id(add-to-cart)|
|Sauce Labs Bike Light|item_0_title_link|id(add-to-cart)|
|Sauce Labs Bolt T-Shirt|item_1_title_link|id(add-to-cart)| 

Scenario: 4.3: 4.4: Validate the number of items in the shopping cart and logout 
When I click on element located by `xpath(.//div[@id="shopping_cart_container"])`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/cart.html`

Then number of elements found by `xpath(//div[@data-test='item-quantity'])` is equal to `3`
Then I logout saucedemo website