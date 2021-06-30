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
    } else {
        [self.favoritesButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    
    // Configure retweet button
    [self.retweetsButton
     setTitle:[NSString stringWithFormat:@"%d", self.tweet.retweetCount]
     forState:UIControlStateNormal];
    if (self.tweet.retweeted) {
         [self.retweetsButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    } else {
        [self.retweetsButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
}

- (IBAction)didTapFavorite:(id)sender {
    
    // Tweet has not been favorited yet -> "like" the tweet
    if (!self.tweet.favorited) {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount++;
        [self refreshData];
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
         }];
        
    // Tweet has been favorited -> "unlike" the tweet
    } else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount--;
        [self refreshData];
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
         }];
    }
}

@end
