Feature: Merge Articles
  As a blog administrator
  In order to merge articles on the same topic
  I want to be able to organize the articles

  Background:
    Given the blog is set up

    And The following users exist:
        | login  | password | email             | profile_id | name | state  |
        | user1  | user1234 | user@hostname.com | 2          | tom  | active |

    And The following articles exist:
      | id | title        | author | body         | state        | allow_comments |
      | 1  | Software I   | admin  | Science I    | published    | true           | 
      | 2  | Software II  | user1  | Science II   | published    | true           |

  Scenario: A non-admin cannot merge articles
    Given I am logged into the admin panel as "user"
    And I am on the article content page
    And I follow "Software I"
    Then I should not see "Merge Articles"

  Scenario: An admin should be able to see "Merge Articles" in the edit page
    Given I am logged into the admin panel as "admin"
    And I am on the article content page
    And I follow "Software II"
    Then I should see "Merge Articles"

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I am logged into the admin panel as "admin"
    And I am on the article content page
    And I follow "Software I"
    And I fill in "merge_with" with the id of article "Software II"
    And I press "Merge"
    Then I should be on the admin content page
    When I follow "Software I"
    Then I should see "Science I"
    And I should see "Science II"

  Scenario: When articles are merged, the merged article should have one author (either one of the authors of the original article)
    Given I am logged into the admin panel as "admin"
    And I am on the article content page
    And I follow "Software I"
    And I fill in "merge_with" with the id of article "Software II"
    And I press "Merge"
    Then I should be on the admin content page
    Then I should see "admin"
    And I should not see "user1"

  Scenario: The title of the new article should be the title from either one of the merged articles.
    Given I am logged into the admin panel as "admin"
    And I am on the article content page
    And I follow "Software I"
    And I fill in "merge_with" with the id of article "Software II"
    And I press "Merge"
    Then I should be on the admin content page
    Then I should see "Software I"
    And I should not see "Software II"

  Scenario: Comments on each of the two original articles need to all carry over and point to the new, merged article.
    Given I am logged into the admin panel as "admin"
    And I am on the article content page
    And I follow "Software I"
    And I fill in "merge_with" with the id of article "Software II"
    And I press "Merge"
    Then I should be on the admin content page
    When I follow "2"
    Then I should see "comment cool"
    And I should see "comment cool"