Feature: Merge Articles
  As a blog administrator
  In order to create or edit categories for articles
  I want to be able to add or change the categories for articles

  Background:
    Given the blog is set up

    And The following users exist:
        | login  | password | email             | profile_id | name | state  |
        | user1  | user1234 | user@hostname.com | 2          | tom  | active |

    And The following articles exist:
      | id | title        | author | body         | state        | allow_comments | comments                                      |
      | 1  | Software I   | admin  | Science I    | published    | true           | author:user1,body:comment cool1,article_id:1  |
      | 2  | Software II  | user1  | Science II   | published    | true           | author:admin,body:comment cool2,article_id:2  |

    And The following categories exist:
      | id | name | keywords   | permalink | description |
      | 1  | Tech | Technology |           |             |

    And I am logged into the admin panel as "admin"
    And I am on the admin index page

  Scenario: An admin should be able to access the categories page
    Given I follow "Categories"
    Then I should see "Name"
    And I should see "Keywords"
    And I should see "Permalink"
    And I should see "Description"

  Scenario: An admin should be able to add a new category
    Given I follow "Categories"
    When I fill in "category_name" with "IT"
    And I fill in "category_keywords" with "Computer Science"
    And I press "Save"
    Then I should be on the categories page
    And I should see "IT"

  Scenario: An admin should be able to delete a category
    Given I follow "Categories"
    When I follow "Delete"
    And I am on the category destroy page for "Tech"
    And I press "delete"
    Then I should be on the categories page 
    And I should not see "Tech"