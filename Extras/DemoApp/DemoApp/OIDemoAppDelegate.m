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
 */
#import "OIDemoAppDelegate.h"
#import "OIMainViewController.h"

@implementation OIDemoAppDelegate  {
@private
  UINavigationController *__navigationController;
  UIWindow *__window;
}

- (void)dealloc {
  [__navigationController release];
  [__window release];
  [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  OIMainViewController *mainViewController = [[[OIMainViewController alloc] init] autorelease];

  __navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];

  __window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [__window addSubview:__navigationController.view];
  [__window makeKeyAndVisible];

  return YES;
}

@end
