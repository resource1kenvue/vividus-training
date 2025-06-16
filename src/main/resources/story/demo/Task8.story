Lifecycle:
Examples:
|userName|password|
|standard_user|secret_sauce|

Scenario: Validate Complete checkout process 

!-- 4.1 4.2: Navigate to the website homepage and Login
Given I am launching saucedemo login page
When I fill <userName> and <password> in login page and submit
When I navigate to product page  

!-- 4.3: Add min and max price items to the shopping cart
When I save text of element located by `xpath(.//*[@data-test="inventory-item-price"])->filter.index(1)` to scenario variable `min`
When I save text of element located by `xpath(.//*[@data-test="inventory-item-price"])->filter.index(6)` to scenario variable `max`
Given I initialize SCENARIO variable `min` with value `#{substringAfter(${min}, $)}`
Given I initialize SCENARIO variable `max` with value `#{substringAfter(${max}, $)}`

When I find GREATER_THAN `0` elements by `xpath(//*[@data-test="inventory-item"])` and for each element do
|step|
|When I save text of element located by `xpath(.//*[@data-test="inventory-item-price"])` to scenario variable `price`|
|Given I initialize SCENARIO variable `actualPrice` with value `#{substringAfter(${price}, $)}`                       |
|Given I initialize SCENARIO variable `min` with value `#{eval(${actualPrice} < ${min} ? ${actualPrice} : ${min})}`    |
|Given I initialize SCENARIO variable `max` with value `#{eval(${actualPrice} > ${max} ? ${actualPrice} : ${max})}`    |

Then `${min}` is equal to `<sortingValueMin>`
Then `${max}` is equal to `<sortingValueMax>`

When I click on element located by `xpath(.//*[text()[contains(.,"${min}")]]//parent::div//button)`
When I click on element located by `xpath(.//*[text()[contains(.,"${max}")]]//parent::div//button)`

When I save text of element located by `xpath(.//span[@data-test="shopping-cart-badge"])` to scenario variable `itemCount`
Then `#{eval(itemCount)}` is equal to `#{eval('<cartBadgeCount>')}`

When I click on element located by `xpath(.//div[@id="shopping_cart_container"])`
When I click on element located by `xpath(.//button[@id="checkout"])`

!-- 4.6: visual checks Scenario 4
When I ESTABLISH baseline with name `testSample3`
When I COMPARE_AGAINST baseline with name `testSample3`

!-- 4.4: Populate checkout data
When I fill $firstName, $lastName and $postalCode in checkout page
When I take screenshot
When I click on element located by `xpath(.//input[@id="continue"])`

!-- 4.7: visual checks Scenario 5
When I ESTABLISH baseline with name `testSample4`
When I COMPARE_AGAINST baseline with name `testSample4`

!-- 4.5: Validate order summary and complete order
When I save text of element located by `xpath(.//div[@data-test="subtotal-label"])` to scenario variable `prices`
Given I initialize SCENARIO variable `SubPrice` with value `#{substringAfter(${prices}, $)}` 
Given I initialize SCENARIO variable `subTotal` with value `#{eval(${min} + ${max})}` 
Then `#{eval(SubPrice)}` is equal to `#{eval(subTotal)}`

When I save text of element located by `xpath(.//div[@data-test="tax-label"])` to scenario variable `tax`
Given I initialize SCENARIO variable `clearTax` with value `#{substringAfter(${tax}, $)}`
Given I initialize SCENARIO variable `finalCalTotal` with value `#{eval(${subTotal} + ${clearTax})}`
Given I initialize SCENARIO variable `finalResult` with value `#{round(${finalCalTotal},2)}` 

When I save text of element located by `xpath(.//div[@data-test="total-label"])` to scenario variable `total`
Given I initialize SCENARIO variable `finalPageResult` with value `#{substringAfter(${total}, $)}` 
Then `#{eval(finalResult)}` is equal to `#{eval(finalPageResult)}`
When I click on element located by `xpath(.//button[@id="finish"])`

When I save text of element located by `tagName(h2)` to scenario variable `message`
Then `${message}` is equal to `Thank you for order!`

Examples:
|sortingValueMin|sortingValueMax|cartBadgeCount|
|     7.99      |     49.99     |     2        |