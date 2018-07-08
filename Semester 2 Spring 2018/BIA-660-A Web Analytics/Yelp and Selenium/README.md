# A project based on Automation of Web Surfing
Write a python script called review.py. The script should implement 4 functions:

- login(username,password): This function uses selenium to login to Yelp.  (5 points)

 

- submitReview(rev_text, rev_rating, restaurantID): this function submits a review for the restaurant with id restaurantID. The parameter rev_text is the review's text. The parameter rev_rating is the review's star rating. The user has to be logged in before this function can be called.  (5 points)

 

- vote(userID): this  function goes to the Yelp profile of the user with id=userID, and marks the first review  (the one at the top of the page) as "useful". The user has to be logged in before this function can be called.  (5 points)

 

- test(username,password,rev_text, rev_rating, restaurantID, userID): This function calls and tests the other 3 functions. Use the Yelp account that you created for the class.  (5 points)


