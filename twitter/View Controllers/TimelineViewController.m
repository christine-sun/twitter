//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "ComposeViewController.h"
#import "DateTools.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayOfTweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchTweets];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
}

- (void)fetchTweets {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.arrayOfTweets = tweets;
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Go to login screen and clear APIManager access tokens
- (IBAction)onLogOutButtonClick:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    // Clear access tokens
    [[APIManager shared] logout];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    
    // Set the user's profile image
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
   // NSData *urlData = [NSData dataWithContentsOfURL:url];
    [cell.iconImageView setImageWithURL:url];
    [cell.iconImageView.layer setCornerRadius:28];
    [cell.iconImageView setClipsToBounds:YES];
    
    cell.tweet = tweet;
    cell.nameLabel.text = tweet.user.name;
    cell.screennameLabel.text = [@"@" stringByAppendingString:tweet.user.screenName];
    cell.tweetTextLabel.text = tweet.text;
    cell.dateLabel.text = [tweet.date shortTimeAgoSinceNow];

    // Configure favorites button
    [cell.favoritesButton
     setTitle:[NSString stringWithFormat:@"%d", tweet.favoriteCount]
     forState:UIControlStateNormal];
    if (tweet.favorited) {
        [cell.favoritesButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    
    // Configure retweet button
    [cell.retweetsButton
     setTitle:[NSString stringWithFormat:@"%d", tweet.retweetCount]
     forState:UIControlStateNormal];
    if (tweet.retweeted) {
         [cell.retweetsButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (void)didTweet:(Tweet*)tweet {
    [self.arrayOfTweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}

@end
