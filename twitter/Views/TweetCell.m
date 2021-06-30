//
//  TweetCell.m
//  twitter
//
//  Created by Christine Sun on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "AppDelegate.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshData {
    // Configure favorites button
    [self.favoritesButton
     setTitle:[NSString stringWithFormat:@"%d", self.tweet.favoriteCount]
     forState:UIControlStateNormal];
    if (self.tweet.favorited) {
        [self.favoritesButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    
    // Configure retweet button
    [self.retweetsButton
     setTitle:[NSString stringWithFormat:@"%d", self.tweet.retweetCount]
     forState:UIControlStateNormal];
    if (self.tweet.retweeted) {
         [self.retweetsButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }
}

- (IBAction)didTapFavorite:(id)sender {
    
    // Update the local tweet model
    if (!self.tweet.favorited) {
        // self.tweet is NULL :(
        
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
    
        // Update cell UI with new favorites count
        [self refreshData];
    
        // Sent POST request to POST favorite/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if (error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else {
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
        [self refreshData]; //need?
    }
}

@end
