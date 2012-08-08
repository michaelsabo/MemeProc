//
//  ShowUserViewController.m
//  MemeProc
//
//  Created by Mike Sabo on 8/6/12.
//  Copyright (c) 2012 Mike Sabo. All rights reserved.
//

#import "ShowUserViewController.h"
#import "ShowPostViewController.h"

@interface ShowUserViewController ()

@end

@implementation ShowUserViewController

@synthesize user_id;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getAllUserPosts];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [postData count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return userName;
            
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

-(void)getAllUserPosts
{
   // NSURL *urlString = [NSURL URLWithString:@"http://localhost:8888/main/index.php/api/users/userData/id/2"];
    NSString* urlString = [NSString stringWithFormat:@"http://memeproc.com/main/index.php/api/users/userData/id/%@", [user_id stringValue]];
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
    postData = [json objectForKey:@"posts"];
    userData = [json objectForKey:@"user"];
    // View the data returned - should be ready for parsing.
    NSLog(@"%@", [postData valueForKey:@"title"]);
    
    titles = [postData valueForKey:@"title"];
    post_id = [postData valueForKey:@"post_id"];
    userName = [userData valueForKey:@"email"];
    
        NSLog(@"%@", post_id);
}


@end
