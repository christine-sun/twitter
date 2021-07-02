//
//  ProfileViewController.m
//  twitter
//
//  Created by Christine Sun on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TweetCell.h"
#import "APIManager.h"
#import "AppDelegate.h"

@interface ProfileViewController () 

@property (weak, nonatomic) IBOutlet UIImageView *bannerView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *bannerURL = [NSURL URLWithString:self.user.bannerUrl];
    [self.bannerView setImageWithURL:bannerURL];
    
    NSURL *iconURL = [NSURL URLWithString:self.user.profilePicture];
    [self.iconImageView setImageWithURL:iconURL];
    [self.iconImageView.layer setCornerRadius:28];
    [self.iconImageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    self.nameLabel.text = self.user.name;
    self.screennameLabel.text = [@"@" stringByAppendingString:self.user.screenName];
    self.descriptionLabel.text = self.user.accountDescription;
    NSString *followersString = [NSString stringWithFormat:@"%d", self.user.followersCount];
    self.followersLabel.text = [followersString stringByAppendingString:@" followers"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
