//
//  ComposeViewController.m
//  twitter
//
//  Created by Christine Sun on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "Tweet.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tweetTextView.delegate = self;
    
}

- (IBAction)onCloseButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)onTweetButton:(id)sender {
    [[APIManager shared]
        postStatusWithText:self.tweetTextView.text
        completion:^(Tweet *tweet, NSError *error) {
            if (tweet) {
                // NSLog(@"Successfully composed tweet");
                [self.delegate didTweet:tweet];
                [self dismissViewControllerAnimated:true completion:nil];
            } else {
                // NSLog(@"Error composing tweet: %@", error.localizedDescription);
            }
    }];
}

@end
