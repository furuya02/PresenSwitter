//
//  Tweet.m
//  PresenSwitter
//
//  Created by hirauchi.shinichi on 2016/05/29.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id)initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        _identifier = [json[@"id"] integerValue];
        _text = json[@"text"];
        NSDictionary *user  = json[@"user"];
        _profileImageUrl = user[@"profile_image_url"];
        _name = user[@"name"];
    }
    return self;
}
@end

