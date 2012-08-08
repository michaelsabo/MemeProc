//
//  ShowPostViewController.m
//  MemeProc
//
//  Created by Mike Sabo on 8/4/12.
//  Copyright (c) 2012 Mike Sabo. All rights reserved.
//

#import "ShowPostViewController.h"

@interface ShowPostViewController ()

@end

@implementation ShowPostViewController
@synthesize txtBody;
@synthesize lblPoster;
@synthesize imgPost;
@synthesize lblTitle, postData, post_id;
@synthesize fullScreen;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
   
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    fullScreen = NO;
    [self LoadPost];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.tabBarController.tabBar.hidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [self setLblTitle:nil];
    [self setTxtBody:nil];
    [self setLblPoster:nil];
    [self setImgPost:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)LoadPost
{
    //NSURL* url = [NSURL URLWithString:@"http://localhost:8888/main/index.php/api/posts/post/id/102"];
   // NSString* urlString = [NSString stringWithFormat:@"http://localhost:8888/main/index.php/api/posts/post/id/%@", [post_id stringValue]];
     NSString* urlString = [NSString stringWithFormat:@"http://memeproc.com/main/index.php/api/posts/post/id/%@", [post_id stringValue]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    // Check if an error occurred
    if (error != nil) {
        NSLog(@"%@", [error localizedDescription]);
        // Do something to handle/advise user.
    }
    
    // Convert the response data to a string.
    //  NSString *responseString = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONWritingPrettyPrinted error:&error];
    postData = [json objectForKey:@"post"];
    //NSLog(@"%@", [json valueForKey:@"post"]);
    // View the data returned - should be ready for parsing.
    //NSLog(@"%@", [postData valueForKey:@"title"]);
   
   // titles = [postData valueForKey:@"title"];
    lblTitle.text = [postData valueForKey:@"title"];
    lblPoster.text = [postData valueForKey:@"post_id"];
    txtBody.text = [postData valueForKey:@"body"];
    [txtBody setEditable:NO];
    
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * is_image = [formatter numberFromString:[postData valueForKey:@"is_image"]];
    
    if ([is_image boolValue])
    {
        //NSString* imageURLString = [NSString stringWithFormat:@"http://localhost:8888/main//uploads/memes/%@", [postData valueForKey:@"link"]];
        NSString* imageURLString = [NSString stringWithFormat:@"http://memeproc.com/main//uploads/memes/%@", [postData valueForKey:@"link"]];
        UIImage* myImage = [UIImage imageWithData:
                        [NSData dataWithContentsOfURL:
                         [NSURL URLWithString:imageURLString]]];
        imgPost.image = myImage;
        imgPost.contentMode = UIViewContentModeScaleAspectFit;
         originalFrame = self.imgPost.frame;
        
    }
    else
        imgPost.hidden = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (fullScreen) [self makeSmall];
    else [self makeFullScreen];
}

-(void)makeFullScreen
{
    fullScreen = YES;
    fullFrame = self.view.bounds;

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [imgPost setFrame:fullFrame];
    [UIView commitAnimations];
     
    
}

- (void)makeSmall {
   
    fullScreen = NO;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [imgPost setFrame:originalFrame];
    self.view.frame = self.view.bounds;
    //self.view.frame = self.view.bounds;
    [UIView commitAnimations];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}


/*
 rounder corners
 button.layer.cornerRadius = 30;
 button.layer.masksToBounds = YES;
 [imgPost setFrame:self.view.bounds];
  */

@end
