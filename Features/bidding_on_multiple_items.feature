Feature: Bidding on multiple items
  In order to win multiple auctions
  As a bidder
  I want to be able to snipe more than one auction at a time

  Background: 
    Given the application is running
    
  Scenario: Sniper bids on multiple items (end to end test)
    Given an auction is selling items item-1, item-2
    When the application starts bidding for item-1, item-2
    Then the auction for item-1 should have received a join request from the sniper
    And  the auction for item-2 should have received a join request from the sniper
    When the auction for item-1 reports a price of 1000 + 98 from "other bidder"
    Then the auction for item-1 should have received a bid of 1098 from the sniper
    When the auction for item-2 reports a price of 500 + 21 from "other bidder"
    Then the auction for item-2 should have received a bid of 521 from the sniper
    When the auction for item-1 reports a price of 1098 + 97 from the sniper
    And  the auction for item-2 reports a price of 521 + 22 from the sniper
    Then the application should show the sniper is winning with a bid of 1098 for item-1
    And  the application should show the sniper is winning with a bid of 521 for item-2
    When the auction for item-1 announces it has closed
    And  the auction for item-2 announces it has closed
    Then the application should show the sniper has won with a bid of 1098 for item-1
    And  the application should show the sniper has won with a bid of 521 for item-2
    