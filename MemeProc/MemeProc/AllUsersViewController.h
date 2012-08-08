//
//  PrefixSecondViewController.h
//  MemeProc
//
//  Created by Mike Sabo on 8/4/12.
//  Copyright (c) 2012 Mike Sabo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixAppDelegate.h"

@interface AllUsersViewController : UIViewController <UITableViewDataSource, UITableViewDataSource, UINavigationControllerDelegate> {
    NSArray* userData;
    NSArray* users;
    NSArray* userId;
}

@end
