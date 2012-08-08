//
//  PrefixAppDelegate.m
//  MemeProc
//
//  Created by Mike Sabo on 8/4/12.
//  Copyright (c) 2012 Mike Sabo. All rights reserved.
//

#import "PrefixAppDelegate.h"

#import "HomeViewController.h"
#import "ShowPostViewController.h"
#import "AllUsersViewController.h"
#import "AddPostViewController.h"

@implementation PrefixAppDelegate

@synthesize navigationController, navigationController2;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
    // Override point for customization after application launch.
    UIViewController *viewController1, *viewController2, *viewController3;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController1 = [[HomeViewController alloc] initWithNibName:@"HomeViewController_iPhone" bundle:nil];
        viewController2 = [[AllUsersViewController alloc] initWithNibName:@"AllUsersViewController_iPhone" bundle:nil];
        viewController3 = [[AddPostViewController alloc] initWithNibName:@"AddPostViewController" bundle:nil];
    } else {
        viewController1 = [[HomeViewController alloc] initWithNibName:@"HomeViewController_iPad" bundle:nil];
        viewController2 = [[AllUsersViewController alloc] initWithNibName:@"AllUsersViewController_iPad" bundle:nil];
        viewController3 = [[ShowPostViewController alloc] initWithNibName:@"AddPostViewController" bundle:nil];
    }
    navController = [[UINavigationController alloc] initWithRootViewController:viewController1];
    navController2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    navigationController = navController;
    navigationController2 = navController2;
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController, navController2, viewController3, nil];
    self.window.rootViewController = self.tabBarController;
   // [self.window setRootViewController:tabbarController];

    [self.window makeKeyAndVisible];
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

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
