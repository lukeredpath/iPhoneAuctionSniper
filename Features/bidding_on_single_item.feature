Feature: Bidding on a single item
  In order to try and win an auction
  As a bidder
  I want to be able to try and snipe bid at the last minute

  Background: 
    Given the application is running
  
  Scenario: Sniper joins an auction
    Given an auction is selling an item named item-1
    When the application joins the auction for item-1
    Then the auction for item-1 should have received a join request from the sniper

  Scenario: Auction closes immediately after sniper has joined an auction
    Given an auction is selling an item named item-1
    And the application has joined the auction for item-1
    When the auction for item-1 announces it has closed
    Then the application should show the sniper has lost the auction for item-1
    
  Scenario: Sniper makes a higher bid but loses
    Given an auction is selling an item named item-1
    And the application has joined the auction for item-1
    When the auction for item-1 reports a price of 1000 + 98 from "other bidder"
    Then the application should show the sniper is bidding 1098 for item-1
    And the auction for item-1 should have received a bid of 1098 from the sniper
    When the auction for item-1 announces it has closed
    Then the application should show the sniper has lost the auction for item-1

  Scenario: Sniper wins an auction by bidding higher
    Given an auction is selling an item named item-1
    And the application has joined the auction for item-1
    When the auction for item-1 reports a price of 1000 + 98 from "other bidder"
    Then the application should show the sniper is bidding 1098 for item-1
    And the auction for item-1 should have received a bid of 1098 from the sniper
    When the auction for item-1 reports a price of 1098 + 7 from the sniper
    Then the application should show the sniper is winning with a bid of 1098 for item-1
    When the auction for item-1 announces it has closed
    Then the application should show the sniper has won with a bid of 1098 for item-1
