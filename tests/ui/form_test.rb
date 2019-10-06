require 'selenium-webdriver'
require 'rspec'
require 'chromedriver-helper'


describe 'testing the form end to end' do
  it 'submits an amount' do
    driver = Selenium::WebDriver.for :chrome
    driver.navigate.to 'http://127.0.0.1:9393'

    driver.find_element(id: 'money').send_keys(2000)
    driver.find_element(id: 'submit').click
    #wait = Selenium::WebDriver::wait.new(timeout:10)
    #wait.until {driver.find_element(i)}
    expect(driver.find_element(id: 'format').text).to eql("Formatted Amount: 2 000.00")
    driver.quit
   end
end