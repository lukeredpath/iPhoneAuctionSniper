Feature: Bidding on a single item
  In order to try and win an auction
  As a bidder
  I want to be able to try and snipe bid at the last minute

  Background: 
    Given the application is running
  
  Scenario: Sniper joins an auction
    Given an auction is selling an item
    When the application is joins the auction
    Then the auction should have received a join request from the sniper
    And the application should show the sniper has joined the auction
    
  Scenario: Auction closes immediately after sniper has joined an auction
    Given an auction is selling an item
    And the application has joined the auction
    When the auction announces it has closed
    Then the application should show the sniper has lost the auction
    
