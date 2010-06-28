//
//  AuctionSniperAppDelegate.m
//  AuctionSniper
//
//  Created by Luke Redpath on 23/06/2010.
//  Copyright LJR Software Limited 2010. All rights reserved.
//

#import "AuctionSniperAppDelegate.h"
#import "AuctionSniperViewController.h"
#import "XMPP.h"
#import "AuctionMessageTranslator.h"
#import "AuctionSniper.h"
#import "Auction.h"

#define kSNIPER_XMPP_USERNAME @"sniper"
#define kSNIPER_XMPP_PASSWORD @"sniper"
#define kXMPP_HOSTNAME        @"localhost"
#define kAUCTION_RESOURCE     @"auction"
#define kAUCTION_ID           1

@interface AuctionSniperAppDelegate ()
- (void)joinAuction;
- (void)subscribeToAuction;
@end

#pragma mark -

@implementation AuctionSniperAppDelegate

@synthesize window;
@synthesize auctionSniperController;

- (void)dealloc 
{
  [xmppStream release];
  [messageTranslator release];
  [window release];
  [super dealloc];
}

XMPPJID *auctionJID() {
  NSString *auctionUser = [NSString stringWithFormat:@"auction-item-%d", kAUCTION_ID];
  return [XMPPJID jidWithUser:auctionUser domain:kXMPP_HOSTNAME resource:kAUCTION_RESOURCE];
}

- (void)sendMessageToAuction:(NSString *)messageBody;
{
  NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
  [body setStringValue:messageBody];
  
  NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
  [message addAttributeWithName:@"type" stringValue:@"chat"];
  [message addAttributeWithName:@"to" stringValue:auctionJID().full];
  [message addChild:body]; 
  
  [xmppStream sendElement:message];
}

- (void)subscribeToAuction;
{
  NSXMLElement *presence = [NSXMLElement elementWithName:@"presence"];
  [xmppStream sendElement:presence];
  
  [presence addAttributeWithName:@"to" stringValue:auctionJID().bare];
	[presence addAttributeWithName:@"type" stringValue:@"subscribed"];
  [xmppStream sendElement:presence];
}

- (void)joinAuction;
{
  [self subscribeToAuction];
  [self sendMessageToAuction:@"SOLVersion: 1.1; Command: JOIN;"];
}

#pragma mark -
#pragma mark XMPPStreamDelegate methods

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
  NSError *authError = nil;
  if (![sender authenticateWithPassword:kSNIPER_XMPP_PASSWORD error:&authError]) {
    NSLog(@"Authentication error: %@", authError);
  }
}

- (void)xmppStream:(XMPPStream *)sender didNotConnect:(NSError *)error
{
  NSLog(@"Failed to connect, %@", error);
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
  [self joinAuction];
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error;
{
  NSLog(@"Failed to authenticate, %@", error);
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
  xmppStream = [[XMPPStream alloc] init];
  xmppStream.hostName = kXMPP_HOSTNAME;
  xmppStream.myJID = [XMPPJID jidWithUser:kSNIPER_XMPP_USERNAME domain:kXMPP_HOSTNAME resource:nil];

  [xmppStream addDelegate:self];
  
  Auction *auction = [[Auction alloc] initWithStream:xmppStream];
  AuctionSniper *auctionSniper = [[AuctionSniper alloc] initWithAuction:auction];
  self.auctionSniperController.auctionSniper = auctionSniper;
  
  messageTranslator = [[AuctionMessageTranslator alloc] initWithAuctionEventListener:auctionSniper];
  [xmppStream addDelegate:messageTranslator];
  
  [auction release];
  [auctionSniper release];
  
  NSError *connectionError = nil;
  if (![xmppStream connect:&connectionError]) {
    NSLog(@"Connection error: %@", connectionError);
  }
  
  [window makeKeyAndVisible];
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application 
{
  [xmppStream disconnect];
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

@end
