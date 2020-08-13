Feature: visit profile page for a representative

  As a registered voter
  So that I can find out more information about a representative
  I want to see a page of their information

Background: representatives in database

  Given the following representatives exist:
  | name             | title                               | ocdid                             | party            |
  | Donald Trump     | President of the United States      | ocd-division/country:us           | Republican Party |
  | Mike Pence       | Vice President of the United States | ocd-division/country:us           | Republican Party |
  | Dianne Feinstein | U.S. Senator                        | ocd-division/country:us/state:ca  | Democratic Party |

Scenario: search for a representative
  Given I am on the search page 
  When I fill in "address" with "California"
  And I press 'Search'
  Then I am on the results page
  And I should see "Donald Trump"
  When I follow "name"
  Then I am on the profile page
  And I should see "Donald Trump"
  And I should not see "Mike Pence"





#   When I go to the edit page for "Alien"
#   And  I fill in "Director" with "Ridley Scott"
#   And  I press "Update Movie Info"
#   Then the director of "Alien" should be "Ridley Scott"

# Scenario: find movie with same director
#   Given I am on the details page for "Star Wars"
#   When  I follow "Find Movies With Same Director"
#   Then  I should be on the Similar Movies page for "Star Wars"
#   And   I should see "THX-1138"
#   But   I should not see "Blade Runner"

# Scenario: can't find similar movies if we don't know director (sad path)
#   Given I am on the details page for "Alien"
#   Then  I should not see "Ridley Scott"
#   When  I follow "Find Movies With Same Director"
#   Then  I should be on the home page
#   And   I should see "'Alien' has no director info"