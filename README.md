# ma-ios-challenge

**Tasks**

1. As a user I should be able to get dynamic deals from a backend service delivered through json. This data can be expected to change between requests, and I would expect my deal list to update accordingly.

    *Tasks*
    * Create a NetworkRequest class to handle the network connections through out the app
    * Update the ViewController class to invoke the NetworkRequest class to get all the dynamic deals
    * Add an activity indicator to make the user wait to display the deals 

    *User Acceptance Criteria* 
    * Given I’ve access to the application
    * When I click the app icon
    * Then I see the list of dynamic deals

2. As a user I should see an image of the deal in the same container as the deal name and price 

    *Tasks*
    * Update the DealTableViewCell class by adding an UIImageView to display the image    
    * Add any 3rd party library or update the network request class to download the image (Check for the image url in the deals response).

    *User Acceptance Criteria* 
    * Given I’ve access to the application
    * When I click on the app icon
    * Then I see the list of dynamic deals with an image to the left side of the tableviewcell


3. As a user I should be able to sort and filter the deal feed using various criteria 

    * Sort By Score
        *Tasks*
        * Add a sort_filter icon to the deals page
        * Present a new ViewController when sort_filter icon clicked
        * Write sort logic to sort the deals from high to low score and display the deals accordingly.
        *User Acceptance Criteria* 
        * Given I’ve access to the application
        * When I click on the app icon
        * And I see the list of dynamic deals with a sort icon at the top right side of the view controller
        * And I click on the sort_filter icon
        * And I click on the sort by score(high to low)
        * And I click on Apply
        * Then I see the deals sorted from high to low score

    * Filter
        *Tasks*
        * Add a sort_filter icon to the deals page
        * Present a new ViewController when sort_filter icon clicked
        * Write filter logic to filter the deals from based on user input in the min and max fields
    *User Acceptance Criteria* 
        * Given I’ve access to the application
        * When I click on the app icon
        * And I see the list of dynamic deals with a sort icon at the top right side of the view controller
        * And I click on the sort_filter icon
        * And I enter the min score and max score
        * And I click on Apply
        * Then I see the deals filtered based on the user entered min and max score 
        
4. As a user I should be able to restart the app and maintain my last filter choice, including any values that may have been put into fields. 
    *Tasks*
    * Add UserDefaults to save the min and max score
    * Add UserDefaults to save the sort selection
    *User Acceptance Criteria* 
    * Given I’ve access to the application
    * When I click on the app icon
    * Then I see the list of dynamic deals based on the last entered filter values and sort selection
    * And I click on the sort_filter icon
    * Then I see the last entered filtered values and sort selection

5. As a user I should be able to rotate my phone into landscape mode and the app should automatically adjust to a landscape layout. 
    *Tasks*
    * Add Autolayout constraints properly when adding each element to the storyboard
    *User Acceptance Criteria* 
    * Given I’ve access to the application
    * When I click on the app icon
    * Then I see the list of deals based
    * And I rotate the phone/simulator
    * Then I see the list of deals without any issues

6. As a user I should be able to see the total number of deals displayed in the deal feed and this number should automatically update when the filter changes. 
    *Tasks*
    * Add a section header to the deals page that displays the total number of deals displayed in the page
    *User Acceptance Criteria* 
    * Given I’ve access to the application
    * When I click on the app icon
    * Then I see the list of dynamic deals with the count of deals displayed
    * And I click on sort_filter icon and update the min and max score
    * And I click on Apply
    * Then I see the updated deals with updated deals count displayed

7. As a user I expect that the data is coming from a remote endpoint and could change dynamically between requests.
    *Tasks*
    * Make sure to handle the network response properly to accommodate any new property changes or value changes
    *User Acceptance Criteria* 
    * Given I’ve access to the application
    * When I click on the app icon
    * Then I see the list of dynamic deals even when there is a change in the network response


**Logs**

I spent around 8-10 hours(apprx) working on this test. I’m kind of busy with my release cycle at the current company and I couldn’t spend time at one stretch else could have done faster. 

**Questions**

1. Did you finish all the work? If not, why? - Yes, I did finish all the work except the comments and upvotes number display and I hope it meets the expectation of the reviewer.
    * Reason why I couldn’t finish the display of upvotes and comments - There is no proper response from the backend. For instance, there is an object which does not have upvotes and comments in the response but later I assumed that comments+upvotes = num_replies. In the object, the num_replies value is 13 and score is 38, which makes the equation x+y = 13 and according to the documentation each upvote is 1point and each comment is 8points which will form an equation of x+8y = 38. So, putting together 7y=25, where y cannot be resolved. So, after doing all the math, I figured out that there is no way to count the number of upvotes and comments and this is the reason why I couldn’t display them in the UI.

2. Did you make any changes to the provided code? If so, what?  - Yes, I made changes to the provided code, some of them are 
    * I created extensions for ViewControllers to handle UITableViewDelegate and UITableViewDataSource separately
    * I created a separate class for UITableViewCell instead of using the provided Cell class, just to improve code readability
    * I created a separate struct class for handling the response from the server to follow the best practices in the industry

3. How would you add additional sorting orders based on the feedback given by the product team? 
    * I would add sort by price from low to high and vice-versa
    * I would add sort by date to see the latest deals
    * I would add sort by ratings to see the popular deals

4. Provide a Retrospective with the following information: 
    * What do you think you did well? - 
        * I was able to complete the assessment, which gave a feeling that I did well
        * I used the best practices like using main thread to update the UI, separating the components as much as possible to give good code readability 
    * What do you think you did not do well? 
        * With due respect, I don’t see anything I didn’t do well with respect to the amount of time I spent on the test. For sure, I could’ve improved the test provided I spent some more time.
    * If you were to take this test a second time, what would you do differently?
        * I would handle all the conditions that might go wrong in the application flow, e.g, if there are no rows in the tableview - handling the error messages, handling the network issues much more robustly, handling the data saving using robust framework like CoreData or realm, making the UI much more user friendly by adding pull to refresh button with good animations.

5. Do you feel this test accurately evaluated your abilities? Why or why not? - I really think the test has enough tasks to evaluate my abilities. It has major components like UITableview, URLSession, structs, extensions etc which most of the iOS applications uses.  


