//
//  PrefixFirstViewController.h
//  MemeProc
//
//  Created by Mike Sabo on 8/4/12.
//  Copyright (c) 2012 Mike Sabo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate> {
    
}

@property NSArray* titles;
@property NSArray* post_id;

@end
