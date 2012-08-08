//
//  ShowPostViewController.h
//  MemeProc
//
//  Created by Mike Sabo on 8/4/12.
//  Copyright (c) 2012 Mike Sabo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowPostViewController : UIViewController <UINavigationControllerDelegate> {
    CGRect originalFrame;
    CGRect fullFrame;
}
@property (strong, atomic) NSArray *postData;
@property (strong, atomic) NSNumber *post_id;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UITextView *txtBody;
@property (strong, nonatomic) IBOutlet UILabel *lblPoster;
@property (strong, nonatomic) IBOutlet UIImageView *imgPost;
@property (assign, nonatomic) BOOL fullScreen;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end
