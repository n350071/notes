# https://qiita.com/tomerun/items/9cb81d7a98150ff22f53
# https://github.com/SeleniumHQ/selenium/wiki/Ruby-Bindings
# https://morizyun.github.io/web/selenium-cheat-sheet.html

# brew tap homebrew/cask
# brew cask install chromedriver
require 'selenium-webdriver'
driver = Selenium::WebDriver.for :chrome # ブラウザ起動

# ログイン処理
driver.navigate.to 'https://nice-service/users/sign_in' # URLを開く
element = driver.find_element(:id, 'user_email')
element.send_keys('naoki@example.com')
element = driver.find_element(:id, 'user_password')
element.send_keys('password')
driver.find_element(:name, 'commit').click

# nice-things
nice_things = [141,4134,541,31445,514314,14,134,134,1414134,1,5,6,767,3,2,4113]

nice_things.each do |nice_id|
  p nice_id
  driver.navigate.to "https://nice-service/nice/#{nice_id}"
  driver.find_element(:id, 'like').click

  wait = Selenium::WebDriver::Wait.new(timeout: 100)

  # 要素が現れるまで待つ
  wait.until { driver.find_element(:class, 'modal-footer').displayed? }
  driver.find_element(:class, 'modal-footer').find_element(:class, 'btn-danger').click
  p nice_things.each
end

# スクリーンショット
# nice_things.each do |nice_id|
#   driver.navigate.to "https://nice-service/nice/#{nice_id}"
#   driver.save_screenshot("./nice_#{nice_id}.png")
# end

driver.quit # ブラウザ終了
