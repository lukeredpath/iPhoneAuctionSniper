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
#import "XMPPAuction.h"
#import "XMPPJID.h"

#define kSNIPER_XMPP_USERNAME @"sniper"
#define kSNIPER_XMPP_PASSWORD @"sniper"
#define kXMPP_HOSTNAME        @"localhost"
#define kAUCTION_RESOURCE     @"auction"
#define kAUCTION_ID           @"item-1"


@implementation AuctionSniperAppDelegate

@synthesize window;
@synthesize auctionSniperController;

- (void)dealloc 
{
  [xmppStream release];
  [translators release];
  [window release];
  [super dealloc];
}

XMPPStream *newXMPPStream(NSString *hostName, NSString *user, id delegate) 
{
  XMPPStream *stream = [[XMPPStream alloc] init];
  stream.hostName = hostName;
  stream.myJID = [XMPPJID jidWithUser:user domain:hostName resource:nil];
  [stream addDelegate:delegate];
  return stream;
}

- (void)joinAuctionForItem:(NSString *)itemID stream:(XMPPStream *)stream
{
  XMPPAuction *auction = [[XMPPAuction alloc] initWithStream:xmppStream itemID:itemID];
  [auctions addObject:auction];
  [auction release];
  
  AuctionSniper *auctionSniper = [[AuctionSniper alloc] initWithAuction:auction auctionID:itemID];
  [self.auctionSniperController addSniper:auctionSniper];
  
  AuctionMessageTranslator *messageTranslator = [[AuctionMessageTranslator alloc] initWithSniperID:xmppStream.myJID.bare eventListener:auctionSniper];
  [stream addDelegate:messageTranslator];
  
  [auction subscribeAndJoin];
  
  [translators addObject:messageTranslator]; // prevent it from being released
  [auctionSniper release];
  [messageTranslator release];
  [auction release];
}

#pragma mark -
#pragma mark XMPP connection delegate

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
  [self joinAuctionForItem:@"item-1" stream:xmppStream];
  [self joinAuctionForItem:@"item-2" stream:xmppStream];
}

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

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error;
{
  NSLog(@"Failed to authenticate, %@", error);
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
  // Translators are not retained by the XMPPStream so we need to keep a reference to them around for now
  // to stop them from being released prematurely. We also need to keep hold of auctions.
  translators = [[NSMutableArray alloc] init];
  auctions = [[NSMutableArray alloc] init];

  xmppStream = newXMPPStream(kXMPP_HOSTNAME, kSNIPER_XMPP_USERNAME, self);
  
  NSError *connectionError = nil;
  [xmppStream connect:&connectionError];
  
  if (connectionError) {
    NSLog(@"Connection error: %@", connectionError);
    abort();
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
