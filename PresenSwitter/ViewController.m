//
//  ViewController.m
//  PresenSwitter
//
//  Created by hirauchi.shinichi on 2016/05/27.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//


#import "ViewController.h"
#import "TweetCell.h"
#import "STTwitter.h"
#import <Accounts/Accounts.h>
#import "Tweet.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.fontSize = 22;

    _tweets = [[Tweets alloc]init];
    _tweets.tableView = self.tableview;

    // ウインドウ透明
    NSWindow *window = [[NSApp windows]objectAtIndex:0];
    [window setOpaque:NO];
    [window setBackgroundColor : [ NSColor clearColor ]];
    [window setHasShadow:NO];
    _scrollView.drawsBackground = NO;
    [_tableview setBackgroundColor:[NSColor clearColor]];
    [_tableview setHeaderView:nil];
    self.view.alphaValue = 0;

    _timer = [NSTimer scheduledTimerWithTimeInterval:5
                                              target:self
                                            selector:@selector(update:)
                                            userInfo:nil
                                             repeats:YES
              ];
}

// キー入力有効
- (BOOL)acceptsFirstResponder
{
    NSWindow *window = [[NSApp windows]objectAtIndex:0];
    [window makeFirstResponder:self];
    return YES;
}

#pragma Action

// キー入力でフォントの拡大・縮小を行う
- (void)keyDown:(NSEvent *)theEvent
{
    switch([[theEvent characters] characterAtIndex:0])
    {
        case '+': // フォント拡大
            self.fontSize += 1;
            break;
        case '0': // フォント縮小
            self.fontSize -= 1;
            break;
    }
    NSLog(@"%c keydown Fontsize=%.0f",[[theEvent characters] characterAtIndex:0],self.fontSize);
    [_tableview reloadData];
}

#pragma TableView datasource

- (NSInteger)numberOfRowsInTableView:(NSTableView*)tableView
{
    return _tweets.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {

    TweetCell *cell = [tableView makeViewWithIdentifier:@"TweetCell" owner:self];
    Tweet *tweet = [_tweets tweetAtIndex:row];

    // ファオントサイズの設定
    NSFont *font = [NSFont fontWithName:cell.labelName.font.fontName size:self.fontSize];
    [cell.labelName setFont:font];
    [cell.labelBody setFont:font];

    cell.labelName.stringValue =  tweet.name;
    cell.labelBody.stringValue =  tweet.text;
    NSURL *url = [NSURL URLWithString:tweet.profileImageUrl];
    [cell.imageIcon setImage:[[NSImage alloc] initWithContentsOfURL: url]];
    return cell;
}

#pragma TableView delegate

// セルの高さ
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    Tweet *tweet = [_tweets tweetAtIndex:row];
    TweetCell *cell = [tableView makeViewWithIdentifier:@"TweetCell" owner:self];
    NSFont *font = [NSFont fontWithName:cell.labelName.font.fontName size:self.fontSize];
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [tweet.text boundingRectWithSize:CGSizeMake(tableView.bounds.size.width, CGFLOAT_MAX)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    return rect.size.height + 50;
}

- (BOOL)selectionShouldChangeInTableView:(NSTableView *)aTableView
{
    return NO;// 選択不可

}

- (void)tableViewColumnDidResize:(NSNotification *)notification
{
    [_tableview reloadData]; // リサイズ
}

#pragma Timer

-(void)update:(NSTimer *)theTimer
{
    // 検索文字列
    NSString *query = @"#cmdevio2016";
//    NSString *query = @"#xamarin";
//
//    NSString *ConsumerKey = @"XXXXXXXXXXXXXXXX";
//    NSString *ConsumerSecret = @"XXXXXXXXXXXXXXXXXXXXXXXXXX";
//    NSString *UserName = @"XXXXXX";
//    NSString *Password = @"XXXXXX";

    NSString *ConsumerKey = @"WDwpsBiA1Jy1tDfe7bZhSFzEL";
    NSString *ConsumerSecret = @"aFzzPT2d2oEruTfX4d320nAWAqBlKytAWKPNk00khjhuOJRBMs";
    NSString *UserName = @"furuya02";
    NSString *Password = @"xxx12#xxx";

    STTwitterAPI *_twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:ConsumerKey
                                                           consumerSecret:ConsumerSecret
                                                                 username:UserName
                                                                 password:Password];
    NSString *since_id = [NSString stringWithFormat:@"%ld",_tweets.since_id];
    [_twitter fetchAndFollowCursorsForResource:@"search/tweets.json"
                                    HTTPMethod:@"GET"
                                 baseURLString:@"https://api.twitter.com/1.1"
                                    parameters:@{@"q":query,@"since_id":since_id}
                           uploadProgressBlock:nil
                         downloadProgressBlock:nil
                                  successBlock:^(id request, NSDictionary *requestHeaders, NSDictionary *responseHeaders, id response, BOOL morePagesToCome, BOOL *stop) {
                                      NSDictionary *json = (NSDictionary *)response;
                                      NSArray *statuses = json[@"statuses"];
                                      NSLog(@"%lu tweet received",(unsigned long)statuses.count);
                                      [_tweets append:statuses];
                                  } pauseBlock:^(NSDate *nextRequestDate) {
                                      NSLog(@"-- rate limit exhausted, nextRequestDate: %@", nextRequestDate);
                                  } errorBlock:^(id request, NSDictionary *requestHeaders, NSDictionary *responseHeaders, NSError *error) {
                                      NSLog(@"-- %@", error);
                                  }];
    
}

@end
