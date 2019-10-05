**Heracles**

Heracles is a web app that converts money into a string format. A user keys in the amount of money  and Heracles formats the amount and displays it back to the user.
 
**Tech / framework** 
- Programming language : Ruby 
- Framework : Sinatra 
- Continous Integration : CircleCI
- UI test : Selenium Webdriver
- Property based tests : Rantly
- Static analysis tool : Code Climate 

**How**
 - Drafted a road map of tasks to do
 - Set up integration for CircleCI and CodeClimate
 - The code base is structured as below
    
    ```bash
   ├── Gemfile
   ├── Gemfile.lock
   ├── README.md
   ├── Rakefile
   ├── app
   │   ├── controller
   │   │   └── money_formatter_controller.rb
   │   ├── helper.rb
   │   └── views
   │       ├── formatted.erb
   │       └── index.erb
   ├── config
   │   └── environment.rb
   ├── config.ru
   └── tests
       ├── end-to-end
       │   └── page-objects-model
       ├── integration
       │   └── test_money_formatter_controller.rb
       ├── test_helper.rb
       └── unit
           └── test_money_formatter_helper.rb
    ```
   1. The app directory contains the controller that receives input from the UI and formats the input using a helper method defined in the helper file. 
      The app directory also includes the views rendered as HTML pages to the user 
   2. There are three test folders, for unit, integration and end to end tests. 
       - The unit test folder holds functionality tests for money formatting method defined in our helper. Rantly is used to generate inputs and aid in property based testing, and Minitest to run tests.
       - The integration test folder holds component tests that test that whenever the controller URL is called, it receives the input, validates and invokes the formatting functionality to run the conversion and return a correct value to the user
       - End to end test folder holds UI tests that ensure the UI components are available ( a input text field, and a 'submit' button). The test goes on to check that when a user clicks 'submit', the input is formatted. 
   3. The Rakefile defines three tasks, one to run each type of test. ( unit, integration and end to end tests)
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
 Rantly generates more than `300 tests` to providing added comfort that the app is tested against a wider range of random strings and numbers.
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
 
 - UI test using Selenium Webdriver


**Running the tests**
 - Run unit tests by running the command `rake unit` 
 - Run integration tests by running the command `rake intgration` 

**Further improvements**
 - Heracles can be deployed to a Sandbox environment after PR pipeline has passed. 
 - End to end tests can be set up to run daily to ensure master is always clean
 - The app can also be Dockerized if one would like to test in containers. 
