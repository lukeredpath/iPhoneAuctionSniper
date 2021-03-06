Feature: Bidding on a single item
  In order to try and win an auction
  As a bidder
  I want to be able to try and snipe bid at the last minute

  Background: 
    Given the application is running
  
  Scenario: Sniper joins an auction
    Given an auction is selling an item
    When the application joins the auction
    Then the auction should have received a join request from the sniper

  @focussed
  Scenario: Auction closes immediately after sniper has joined an auction
    Given an auction is selling an item
    And the application has joined the auction
    When the auction announces it has closed
    Then the application should show the sniper has lost the auction
    
  Scenario: Sniper makes a higher bid but loses
    Given an auction is selling an item
    And the application has joined the auction
    When the auction reports a price of 1000 + 98 from "other bidder"
    Then the application should show the sniper is bidding 1098
    And the auction should have received a bid of 1098 from the sniper
    When the auction announces it has closed
    Then the application should show the sniper has lost the auction

  @focussed
  Scenario: Sniper wins an auction by bidding higher
    Given an auction is selling an item
    And the application has joined the auction
    When the auction reports a price of 1000 + 98 from "other bidder"
    Then the application should show the sniper is bidding 1098
    And the auction should have received a bid of 1098 from the sniper
    When the auction reports a price of 1098 + 7 from the sniper
    Then the application should show the sniper is winning with a bid of 1098
    When the auction announces it has closed
    Then the application should show the sniper has won with a bid of 1098
    