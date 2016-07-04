//
//  Tweets.m
//  PresenSwitter
//
//  Created by hirauchi.shinichi on 2016/05/29.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//

#import "Tweets.h"

@interface Tweets()
@property (strong,nonatomic) NSMutableArray<Tweet*> *tweets;
@end

@implementation Tweets

- (id)init
{
    self = [super init];
    if (self) {
        _tableView = nil;
        _tweets = [NSMutableArray array];
        _since_id = 0;
    }
    return self;
}

- (NSInteger) count{
    return _tweets.count;
}

- (void) append:(NSArray *)statuses
{
    NSInteger count = 0;
    for(NSDictionary *json in statuses.reverseObjectEnumerator){
        Tweet *tweet =[[Tweet alloc]initWithJson:json];
        if ( [self tweetWithIdentifier:tweet.identifier] == nil )
        {
            [_tweets insertObject:tweet atIndex:0];
            if (self.since_id < tweet.identifier)
            {
                self.since_id = tweet.identifier;
            }
            // 一旦データを更新した後、１行づつスクロールする
            if (_tableView != nil){
                [_tableView scrollRowToVisible:count++];
                [_tableView reloadData];
            }
            for (NSInteger n=0; n < count; n++)
            {
                // スクロール時にアニメーションする場合、ここで処理する
                [_tableView scrollRowToVisible:count-n];
            }
        }
    }
}

- (Tweet *) tweetWithIdentifier:(NSInteger)identifier
{
    for (Tweet *t in _tweets)
    {
        if ( t.identifier == identifier){
            return t;
        }
    }
    return nil;
}

- (Tweet *)tweetAtIndex:(NSUInteger)index
{
    return [_tweets objectAtIndex:index];
}

@end

