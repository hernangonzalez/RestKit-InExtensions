//
//  InViewController.m
//  RestkitExtensions
//
//  Created by Hernan Gabriel Gonzalez on 1/11/14.
//  Copyright (c) 2014 Hernan Gabriel Gonzalez. All rights reserved.
//

#import "InViewController.h"
#import <RestKit/RestKit.h>
#import "RestKit+InExtensions.h"
#import "RKTweet.h"
#import "RKTUser.h"

@interface InViewController ()
@property (nonatomic, strong) NSArray* tweets;
@end

@implementation InViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Load the object model via RestKit
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    // Success
    __weak typeof(self) weakSelf = self;
    RKObjectRequestSuccessBlock successBlock = ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
    {
        NSArray* statuses = [mappingResult array];
        [weakSelf setTweets:statuses];
        [[weakSelf tableView] reloadData];
    };
    
    // Error
    RKObjectRequestFailureBlock errorBlock = ^(RKObjectRequestOperation *operation, NSError *error)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        NSLog(@"Hit error: %@", error);
    };
    
    // GET Objects
    RKTUserStatus* userStatus = [[RKTUserStatus alloc] init];
    [userStatus setUsername:@"indebateam"];
    [objectManager getObject:userStatus
                        path:nil
                  parameters:nil
                     success:successBlock
                     failure:errorBlock];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tweets count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    RKTweet* tweet = [_tweets objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[tweet text]];
    [[cell detailTextLabel] setText:[[tweet user] name]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RKTweet* tweet = [_tweets objectAtIndex:[indexPath row]];
    NSURL* tweetURL = [NSURL URLWithString:[tweet urlString]];
    if ([[UIApplication sharedApplication] canOpenURL:tweetURL])
    {
        [[UIApplication sharedApplication] openURL:tweetURL];
    }
}


@end
