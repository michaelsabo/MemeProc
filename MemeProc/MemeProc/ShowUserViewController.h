//
//  ShowUserViewController.h
//  MemeProc
//
//  Created by Mike Sabo on 8/6/12.
//  Copyright (c) 2012 Mike Sabo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowUserViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray* titles;
    NSArray* post_id;
    NSString* userName;
    NSArray* postData;
    NSArray* userData;
}

@property (retain, atomic)NSNumber* user_id;

@end
