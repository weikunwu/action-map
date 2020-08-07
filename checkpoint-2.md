## App Overview

ActionMap seeks to provide an integrated, seamless, and shareable platform that makes it easier for voters to connect with the progressive community while at the same time enabling progressive organizations, candidates, and elected leaders to reach new activists. The idea behind the application is to allow the user to visualize the political environment within all levels of government while also providing a platform to contact and voice their opinions to the decision makers within politics. This happens through attending events in their community, and sharing news articles related to a particular candidate and sharing their opinion. By asking the user to provide a news article before giving the candidate a score on a particular issue, it adds a layer of reputability to the score. Users can discover candidates by clicking on a map location, or searching for their local address.

One of the big emphasis on this project is that there will be very little hand-holding. We’ll start you off with some legacy code, which will be a basic Rails app with a few models already implemented, an external API being used (namely the Google Civic Information API), Javascript code for the map, and an asset pipeline (Webpacker).

Another important part: testing! Throughout this whole project, you’ll be expected to add tests where you see fit, leveraging both BDD with Cucumber and Capybara, as well as TDD with Rspec. CHIPS 7.7 and 8.9 are great resources to look at when deciding what is testable, and with which technique. When it comes to stubbing external APIs (a big portion of this project), we’ll give you some extra tips on how to do so.

#### Intended User Flow:

A user can search for candidates in one of two ways:

* **Entering their address into the search field** -OR-

* **Clicking on a state in the US Map**.
 * When a state is clicked, it will redirect the user to that state's map, on which the state's counties will be selectable. When a county is selected, it will take the user to a page with that county's representatives.

Once on a particular place’s representatives list, a user can view any one representatives’ associated news articles, add their own, and score it.

#### Part 1: Representatives

##### Representatives

The Representatives model is the first thing we’ll be working on as part of this app. It has some basic functionality; however, there’s much to be desired.

Let’s take a look at what’s already there:
We have a `representative` MVC structure already laid out. Take a look in app/views/representatives, app/models, and app/controllers.
A basic `representative` database model. This includes the representative name, OCD (Open Civic Data) ID, and office/title.
An association with `news_items`. As you can see, a `representative` has_many `news_items`.  
RepresentativesController and SearchController. The SearchController handles calling the Google Civic API.

| OCD ID | Representative Name | Representative Title | Created At | Updated At
| :------------- | :------------- | :------------- | :------------- | :------------- |
For use with Google Civic API | For use with Google Civic API | For use with Google Civic API | Auto-generated | Auto-generated

This is the preliminary database model for our App.

**TASK 1**: Creating and Adding to the Representatives Profile Page

* All the information we have about our representatives are their name, OCD ID, and office! We want it to show a lot more, including address (street, city, state, zip), political party, and a photo.
    * The `representative` profile page hasn’t been created (will need to be at views/representatives/show.html.haml). You’ll need to create this.
    * The profile page should be linked from views/representatives/search.html.haml, as well as anywhere the representative name appears in views/news_items.
    * This information will come from the Google Civic Information API. See the Representatives controller and model for a basic implementation of getting some fields.
    * This will involve adding to the existing migration for the `representatives` model, so you can store the new information.
    * You’ll also need to make the representative’s Profile page look good! Don’t spend too much time styling, but you do have access to the full powers of Bootstrap! It should look usable when users come to your site. Be creative!
* **Testing**: Refer to ESaaS Chapter 8 Section 4 (Stubbing the Internet), and this unreleased [CHIP](https://github.com/saasbook/hw-rspec-rails-intro/blob/master/part4.md), which serves as a walkthrough for how to mock out web requests. Use these two resources to add RSpec tests that increase coverage for this portion of the app.

#### Part 2: The Counties Map

For this part, you should explore the interconnectivity between the various controllers, models, and views that allow the app to search the Google Civic Information API. Starting in views/representatives/index.html.haml, trace the search code all the way to views/representatives/search.html.haml. Also, read ‘[understand the code](./understanding-the-code.md) to see how the map works in JavaScript.

Understanding this will make the next task much easier.

**TASK 2**: Making the Map Functional

The map is broken! You can click on a state, and it’ll show you a list of counties, but there’s no way to then click on a county to show it’s representatives. It’s up to you to figure out how to fix it.
This doesn’t require a lot of code changes, but does require you to use a mix of your basic JavaScript knowledge and creativity. Figure out which URL you’ll need to modify so that a click on a county triggers the `search#search`route!

#### Part 3: News Articles + Issues + Ratings

The Representatives table is associated with many news articles. What we’d like you to do in this section is add a new column to News Articles to make it more specific, and a new model (Ratings) to get a particular user’s opinion of a candidate’s view on an issue, based on a news article.

**TASK 3**: Set up the News Article Rating infrastructure

* For any associated news article, add an ‘Issue’ column (similar to adding a Director column to Movies in CHIP 8.9) to News Articles to associate an article with a particular issue.
    * This field should be populated by a dropdown on the ‘Create News Article’ page, to associate an issue with a particular article. It should be drawn from the following list:
`["Free Speech", "Immigration", "Terrorism", "Social Security and Medicare", "Abortion", "Student Loans", "Gun Control", "Unemployment", "Climate Change", "Homelessness", "Racism", "Tax Reform", "Net Neutrality", "Religious Freedom", "Border Security", "Minimum Wage", "Equal Pay"]`

* You should also add a new migration for the Ratings model, which should be associated with News Articles in the following way: a news article should have many ratings, and a user should be associated with many ratings.
    * Rating should also be a field populated by a dropdown on the ‘Create News Article’ page, to associate an issue with a particular article. A rating should be on a scale of 1-5.


#### Part 4: Your Own External API

This part of the project comes with a choice: whether you’d like to augment the Representatives portion of the app, or the News Articles portion.

**Option 1: ProPublica Campaign Finance API**: Your first option for this project is to add additional details about campaign finances for US Presidents, Senators, and Congressional Representatives.

[ProPublica Campaign Finance API](https://projects.propublica.org/api-docs/campaign-finance/candidates/#get-top-20-candidates-in-specific-financial-category) is the link to the API.

The recommended way to approach this: add a new model, controller, and set of views for the “Campaign Finance” information we’ll be accessing. Then, using the link above (which links specifically to the “Get Top 20 Candiates in a Specific Financial Category” part of the API), set up a page that shows 2 dropdowns. One will be for the “Cycle” parameter; the other for “Category”. Restrict the selections to what the API allows. Then, once a user selects a specific category and election cycle, allow them to click a ‘Search’ button to show a table with the top 20 candidates in that category that cycle.

**Option 2: News API**: Your second option for this project is to add an option on a particular representative’s ‘Add a News Article’ page to include options to prefill the “Link” and “Title” fields.

[News API](https://newsapi.org/s/google-news-api) is the link to the API.

The recommended way to approach this: add code to the controller and view that display the news article. Once a user has selected a particular issue and representative from the dropdown, send a query to the API that displays the top 5 articles from that query. Use radio buttons to display each of the 5 articles; if one of them is selected, it should render the “Link” and “Title” fields of the form obsolete, and populate it with the output of the API. If none of the articles from the API are selected, then you should still require the user to fill in the “Link” and “Title” fields.

Secrets management will play an important role here, whichever option you end up choosing, as will stubbing out and testing external APIs. Refer to the earlier Representatives section for a resource on stubbing out the internet.
