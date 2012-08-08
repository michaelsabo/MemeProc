//
//  PrefixAppDelegate.h
//  MemeProc
//
//  Created by Mike Sabo on 8/4/12.
//  Copyright (c) 2012 Mike Sabo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrefixAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabbarController;
    UINavigationController *navController;
    UINavigationController *navController2;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic)UINavigationController *navigationController;
@property (strong, nonatomic)UINavigationController *navigationController2;

@end
