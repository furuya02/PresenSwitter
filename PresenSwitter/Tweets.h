//
//  Tweets.h
//  PresenSwitter
//
//  Created by hirauchi.shinichi on 2016/05/29.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "Tweet.h"

/**
 Tweetの配列を格納するクラス
 */
@interface Tweets : NSObject

@property (nonatomic,weak) NSTableView *tableView;
@property (nonatomic) NSInteger since_id; // 最後のメッセージID

- (void) append:(NSArray *)statuses;
- (NSInteger) count;
- (Tweet *)tweetAtIndex:(NSUInteger)index;

@end
