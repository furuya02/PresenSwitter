//
//  ViewController.h
//  PresenSwitter
//
//  Created by hirauchi.shinichi on 2016/05/27.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Tweets.h"

@interface ViewController : NSViewController<NSTableViewDataSource, NSTableViewDelegate>

@property (strong,nonatomic) Tweets * tweets;
@property (weak) IBOutlet NSTableView *tableview;
@property (weak) IBOutlet NSScrollView *scrollView;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) float fontSize;

@end

