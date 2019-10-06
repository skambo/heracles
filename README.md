**Heracles** 
[![CircleCI](https://circleci.com/gh/skambo/heracles/tree/master.svg?style=svg)](https://circleci.com/gh/skambo/heracles/tree/master)
[![Maintainability](https://api.codeclimate.com/v1/badges/52b71c66875df2dbfd4e/maintainability)](https://codeclimate.com/github/skambo/heracles/maintainability)


Heracles is a web app that converts money into a string format. A user keys in the amount of money  and Heracles formats the amount and displays it back to the user.
 
**Tech / framework** 
- Programming language : Ruby 
- Framework : [Sinatra](http://sinatrarb.com/) 
- Continous Integration : CircleCI
- Static analysis tool : Code Climate 
- Linting : [Rubocop](https://rubocop.readthedocs.io/en/stable/)
- Unit tests : MiniTest
- Integration tests : MiniTest
- UI tests : Selenium WebDriver
- Property based tests : [Rantly](https://github.com/hayeah/rantly)


**How**
 - Drafted a road map of tasks for implementation of the Heracles app
 - Set up integration for CircleCI and CodeClimate
 - Structured the code base as shown below
    
  ```bash
  |-- Gemfile
  |-- Gemfile.lock
  |-- README.md
  |-- Rakefile
  |-- app
  |   |-- controller
  |   |   `-- money_formatter_controller.rb
  |   |-- helper.rb
  |   `-- views
  |       |-- formatted.erb
  |       `-- index.erb
  |-- bin
  |   |-- integration_test.sh
  |   |-- lint.sh
  |   |-- ui_test.sh
  |   `-- unit_test.sh
  |-- config
  |   `-- environment.rb
  |-- config.ru
  |-- definitions
  |   `-- format_amount_1.0.yml
  `-- tests
      |-- integration
      |   `-- test_money_formatter_controller.rb
      |-- test_helper.rb
      |-- ui
      |   |-- form_test.rb
      |   `-- page-objects
      `-- unit
          `-- test_money_formatter_helper.rb
  ```
   1. The app directory contains the controller that receives input from the UI and formats the input using a helper 
      method defined in the helper file. 
      The app directory also includes the views rendered as HTML pages to the user 
   2. There are three test folders, for unit, integration and ui tests. 
       - The unit test folder holds functionality tests for money formatting method defined in our helper. 
       Rantly is used to generate inputs and aid in property based testing, and Minitest as the unit test framework.
       - The integration test folder holds component tests that test that whenever the controller URL is called, it receives the input, 
       validates and invokes the formatting functionality to run the conversion and return a formatted string.
       - UI folder holds UI tests that ensure the UI components are available ( an input text field, and a 'submit' button).
        The test goes on to check that when a user clicks 'submit', the input is formatted. 
   3. The Rakefile defines three tasks, one to run each type of test. ( unit, integration and ui tests)
   4. The Gemfile lists the dependencies used by the Heracles app. 
   5. The config file imports the application and makes it available for use.
    
 
**How to install**
 - Pre - requisites 
 -      Install Ruby 2.6.3
 - Run `bundle install`
 - Run `shotgun` to start the application server
 

**Type of tests**

There are a combination of tests running on Heracles at different levels these include;
 - Unit tests written using Minitest and Rantly, for property based testing. Below is an example of property based test results. 
 Rantly generates more than `300 tests` hopefully, providing additional comfort that the app is tested against a wider range of random strings and numbers.
 ```bash
# Running:

.
..........
SUCCESS - 100 successful tests
.
..........
SUCCESS - 100 successful tests
.
..........
SUCCESS - 100 successful tests
.

Finished in 0.009443s, 423.5942 runs/s, 32193.1583 assertions/s.

4 runs, 304 assertions, 0 failures, 0 errors, 0 skips

 ```
 
 - Three integration tests are included, and these include an integration test that interaction between the helper and controller, 
  basically, we test the flow where we post to the controller, which then invokes our helper and the helper formats the money. 
  The remaining integration tests check the flow that the controller does not accept empty money input from a user or string input, 
  if any such invalid input is fed, a flash error message is displayed to the user.
 -`Rubocop` is installed to run linting checks on Heracles. It has also been configured to run the checks on the CI pipeline
 - UI test using Selenium Webdriver and RSpec. There is one UI test that verifies that the amount inputted is formatted and
 the formatted amount is correct. To run the test, type `rspec tests/ui/form_test.rb` 

**CI pipeline setup**
- The CircleCI pipeline configuration can be found at `/heracles/.circleci/config.yml`. 
- The different types of tests are configured in isolated tasks on CircleCI ensuring they run in parallel. The benefits of
  this is enhanced test execution performance. 


**Running the tests**
 - Run unit tests by running the command `rake unit` 
 - Run integration tests by running the command `rake intgration` 
 - Run UI tests by running the command `rspec tests/ui/form_test.rb`
 - Run linting tests with the command `rubocop`

**Further improvements**
 - Heracles can be Dockerized to standardize testing and deployment environments. 
 - Heracles can be deployed to a Sandbox environment after PR pipeline has passed. To allow for exploratory testing.
 - Tests; 
    - The tests can be extended for better optimization. For example, if there was a use case, we can make use of test doubles 
    (mocks, stubs, spies, fakes, dummies) in place of real objects that the code under unit test will depend on.
    - Integration tests on the other hand test a group of components hence there’s no avoiding use of real objects (dependencies). 
    So for example, we can take advantage of Dockerization to optimize for speed and efficiency. 
    - The UI tests can be set up to run daily to ensure what's merged into master is always clean. If Heracles is to to be
    extended in future with many more pages, we would use Page Object Model to separate HTML tag selector code from the actual test code. 
    This makes the tests simpler, more readable and allows reuse of tag selectors.
    - Contract tests can also be added. A Swagger file documenting `/api/v1/formatAmount` has been added and can be found in 
    `/heracles/definitions/format_amount_1.0.yml`. If Heracles was to be extended in future, contract tests would protect against
    regression. 
 - Extending the API; 
    - `/api/v1/formatAmount` is versioned for backward compatibility. Future enhancements of the API should be done in a
    new version. For example, a new version can take in `precision` and `delimiter` as options in formatting money. The ability 
    to define `precision` and `delimiter` options is already catered for in the helper, with default values. 
    - The code structure and design, has considered and implemented component isolation in such a way that any future refactors/
    enhancements on one component do not affect the rest. For example, by separating out the `format_money` functionality into a
    helper, and leaving the controller to handle the interaction between Heracle and the user, implies that future changes to the
    controller do not affect the `format_money` functionality.
     
