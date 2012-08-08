//
//  PrefixSecondViewController.m
//  MemeProc
//
//  Created by Mike Sabo on 8/4/12.
//  Copyright (c) 2012 Mike Sabo. All rights reserved.
//

#import "AllUsersViewController.h"
#import "ShowUserViewController.h"

@interface AllUsersViewController ()

@end

@implementation AllUsersViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Users", @"Users");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getAllUsers];
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

-(void)getAllUsers
{
  //  NSURL *url = [NSURL URLWithString:@"http://localhost:8888/main/index.php/api/users/allusers"];
    NSURL *url = [NSURL URLWithString:@"http://memeproc.com/main/index.php/api/users/allusers"];
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
    userData = [json objectForKey:@"users"];
    userId = [userData valueForKey:@"user_id"];
    users = [userData valueForKey:@"email"];
    // View the data returned - should be ready for parsing.
  //  NSLog(@"%@", [userData valueForKey:@"email"]);
    
    
  //  post_id = [userData valueForKey:@"post_id"];
    
}

/*********************************************************************************************
 Table Stuff
 **********************************************************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [users count];
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *DefaultCellIdentifier = @"DefaultCellIdentifier";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:DefaultCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DefaultCellIdentifier];
    }
    
    for (int count = 0; count < [users count]; count++)
    {
        if (indexPath.section == 0 && indexPath.row == count) {
            cell.textLabel.text = [users objectAtIndex:count];
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
        NSNumber * user_id = [formatter numberFromString:[userId objectAtIndex:[indexPath row]]];
        ShowUserViewController *suvc = [[ShowUserViewController alloc] initWithNibName:@"ShowUserViewController_iPhone" bundle:nil];
        suvc.user_id = user_id;
        
        
        //if (self.navigationController == nil)
        [self.navigationController pushViewController:suvc animated:YES];
    } 
    
    [aTableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
