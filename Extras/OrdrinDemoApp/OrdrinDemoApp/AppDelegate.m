/**
 * Copyright (c) 2012, Tapmates s.r.o. (www.tapmates.com).
 *
 * All rights reserved. This source code can be used only for purposes specified 
 * by the given license contract signed by the rightful deputy of Tapmates s.r.o. 
 * This source code can be used only by the owner of the license.
 * 
 * Any disputes arising in respect of this agreement (license) shall be brought
 * before the Municipal Court of Prague.
 *
 *  @author(s):
 *      Petr Reichl (petr@tapmates.com)
 *      Daniel Krezelok (daniel.krezelok@tapmates.com)
 */

#import "AppDelegate.h"
#import "AddressFormViewController.h"
#import "OICore.h"
#import "OrdrinDemo.h"
#import "AccountViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc {
  [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [[UIApplication sharedApplication] setStatusBarHidden:YES];
  [[OIAPIClient sharedInstance] setApiKey:OI_DEVELOPER_KEY];
  
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  self.window.backgroundColor = [UIColor whiteColor];
    
  AccountViewController *accountViewController = [[AccountViewController alloc] init];
  AddressFormViewController *addressFormViewController = [[AddressFormViewController alloc] init];
  
  UINavigationController *accountNavController = [[UINavigationController alloc] initWithRootViewController:accountViewController];  
  UINavigationController *addressNavController = [[UINavigationController alloc] initWithRootViewController:addressFormViewController];
  
  UITabBarController *tabBarController = [[UITabBarController alloc] init];
  tabBarController.viewControllers = [NSArray arrayWithObjects:addressNavController, accountNavController, nil];
  
  self.window.rootViewController = tabBarController;
  [self.window makeKeyAndVisible];
  
  OI_RELEASE_SAFELY( accountViewController );
  OI_RELEASE_SAFELY( accountNavController );  
  OI_RELEASE_SAFELY( addressNavController );
  OI_RELEASE_SAFELY( addressFormViewController );
  OI_RELEASE_SAFELY( tabBarController );
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
