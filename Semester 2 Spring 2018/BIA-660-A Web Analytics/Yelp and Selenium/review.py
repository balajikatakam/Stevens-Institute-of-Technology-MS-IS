from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from fake_useragent import UserAgent
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.common.exceptions import TimeoutException
from time import sleep

ua=UserAgent()
dcap = dict(DesiredCapabilities.PHANTOMJS)
dcap["phantomjs.page.settings.userAgent"] = (ua.random)
service_args=['--ssl-protocol=any','--ignore-ssl-errors=true']
driver = webdriver.Chrome('chromedriver.exe',desired_capabilities=dcap,service_args=service_args)


def login(username,password):
    
    driver.get("https://www.yelp.com")
    
    path = driver.find_element_by_id("header-log-in")
    path.click()
    
    loginPage=driver.find_element_by_id('ajax-login')
    loginPage.find_element_by_id("email").send_keys(username)
    loginPage.find_element_by_id("password").send_keys(password)

    driver.find_element_by_xpath('//*[@id="ajax-login"]/button').click()

    
#function to submit a review and rating for a restuarant
def submitReview(review, rating, restaurantID):
    #access restaurant in yelp website
    url = "https://www.yelp.com/biz/" + restaurantID   
    driver.get(url)
               
    #find and click on the write review button
    writeReviewBtn = driver.find_element_by_xpath('//*[@id="wrap"]/div[2]/div/div[1]/div/div[3]/div[2]/div/a')
    writeReviewBtn.click()
    
    #finding form fields to post review text field with review
    reviewInp = driver.find_element_by_class_name("review_input__1o94S") #find field to input review
    reviewInp.send_keys(review) #enter review
    ratingInp = driver.find_elements_by_class_name("input__3qblJ") #find field to input rating
    ratingInp[rating-1].click() #click on star for rating
    form = driver.find_element_by_tag_name('form') #post button container
    postBtn = form.find_element_by_tag_name('button') #find button to post a review
    postBtn.click() #click to post a review
    
    #wait until default page loads
    try: myElem = WebDriverWait(driver, 3).until(EC.presence_of_element_located((By.XPATH, '/html/body/div[4]/div[2]/div/div[1]')))
    except TimeoutException: print ("Loading took too much time to load logged in user profile!")
    
   
def vote(userID):
#    ua=UserAgent()
#    dcap = dict(DesiredCapabilities.PHANTOMJS)
#    dcap["phantomjs.page.settings.userAgent"] = (ua.random)
#    service_args=['--ssl-protocol=any','--ignore-ssl-errors=true']
#    driver = webdriver.Chrome('chromedriver.exe',desired_capabilities=dcap,service_args=service_args)
    url= 'https://www.yelp.com/user_details?userid=' + userID 
    driver.get(url)
    userButton = driver.find_element_by_xpath('//*[@id="super-container"]/div/div[2]/div/div[1]/div/div/ul/li[1]/div/div[2]/div[2]/div[1]/ul/li[1]/a')
    userButton.click()
   
def test(username,password,rev_text, rev_rating, restaurantID, userID):
    login(username, password)
    submitReview(rev_text, rev_rating, restaurantID)
    vote(userID)
    
if __name__=='__main__':
    test('smathew23@gmail.com','StevensProject!23','Best resturant in town; great food; good ambiance; Best resturant in town; great food; good ambiance; Best resturant in town; great food; good ambiance',4,'grand-vin-hoboken','5d9KJIqgGi1XskSXY3bZpg')



#
