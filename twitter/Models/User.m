//
//  User.m
//  twitter
//
//  Created by Christine Sun on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
        self.bannerUrl = dictionary[@"profile_banner_url"];
        self.accountDescription = dictionary[@"description"];
        self.followersCount = [dictionary[@"followers_count"] intValue];
        self.tweetsCount = [dictionary[@"statuses_count"] intValue];
        self.userID = [dictionary[@"id"] intValue];
    }
    
    return self;
}

@end
