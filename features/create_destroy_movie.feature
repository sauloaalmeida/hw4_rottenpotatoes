Feature: create and destroy movies

As a movie buff
So that I can add and remove data
I want to create and destroy movies

Background: movies in database

Given the following movies exist:
| title | rating | director | release_date |
| Star Wars | PG | George Lucas | 1977-05-25 |
| Blade Runner | PG | Ridley Scott | 1982-06-25 |
| Alien | R | | 1979-05-25 |
| THX-1138 | R | George Lucas | 1971-03-11 |

Scenario: destroy a movie
Given I am on the homepage
When I check the following ratings: PG,R,PG-13,G,NC-17
And I press "ratings_submit"
And I follow "More about Alien"
And I press "Delete"
Then I should be on the home page
And I should see "Movie 'Alien' deleted."

Scenario: create a movie
Given I am on the homepage
When I check the following ratings: PG,R,PG-13,G,NC-17
And I press "ratings_submit"
And I follow "Add new movie"
And I fill in "Title" with "xpto film"
And I fill in "Director" with "xpto director"
And I press "Save Changes"
Then I should be on the home page
And I should see "xpto film"
And I should see "xpto director"
