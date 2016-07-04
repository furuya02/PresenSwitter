//
//  Tweet.h
//  PresenSwitter
//
//  Created by hirauchi.shinichi on 2016/05/29.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//


#import <Foundation/Foundation.h>

/**
Tweetを格納するクラス
 */
@interface Tweet : NSObject

@property (nonatomic, readonly) NSInteger identifier;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *profileImageUrl;
@property (strong, nonatomic) NSString *name;

- (id)initWithJson:(NSDictionary *)json;

@end
