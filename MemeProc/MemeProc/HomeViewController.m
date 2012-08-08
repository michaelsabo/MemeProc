//
//  PrefixFirstViewController.m
//  MemeProc
//
//  Created by Mike Sabo on 8/4/12.
//  Copyright (c) 2012 Mike Sabo. All rights reserved.
//

#import "HomeViewController.h"
#import "ShowPostViewController.h"
#import "PrefixAppDelegate.h"

@interface HomeViewController ()

@end


@implementation HomeViewController

@synthesize titles, post_id;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Posts", @"Posts");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self getRecentPosts];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.tabBarController.tabBar.hidden = NO;
    [super viewWillAppear:animated];
    
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Recent Posts";
            
        default:
            return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *DefaultCellIdentifier = @"DefaultCellIdentifier";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:DefaultCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DefaultCellIdentifier];
    }
        
    for (int count = 0; count < [titles count]; count++)
    {
        if (indexPath.section == 0 && indexPath.row == count) {
            cell.textLabel.text = [titles objectAtIndex:count];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
       // [self.navigationController pushViewController:mvc animated:YES];
    }
       
    if (self.navigationController != nil)
    {
        NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * post_number = [formatter numberFromString:[post_id objectAtIndex:[indexPath row]]];
        ShowPostViewController *spvc = [[ShowPostViewController alloc] initWithNibName:@"ShowPostViewController_iPhone" bundle:nil];
        spvc.post_id = post_number;

                         
        //if (self.navigationController == nil)
        [self.navigationController pushViewController:spvc animated:YES];
    }

    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        
       
}

/************************************************************************

*******************************************************************************************************/

-(void)getRecentPosts
{
   // NSURL *url = [NSURL URLWithString:@"http://localhost:8888/main/index.php/api/posts/page/page/1"];
    NSURL *url = [NSURL URLWithString:@"http://memeproc.com/main/index.php/api/posts/page/page/1"];
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
    NSArray *postData = [json objectForKey:@"posts"];
    
    // View the data returned - should be ready for parsing.
    NSLog(@"%@", [postData valueForKey:@"title"]);
    
    titles = [postData valueForKey:@"title"];
    post_id = [postData valueForKey:@"post_id"];
      
}



@end
