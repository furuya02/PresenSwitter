//
//  TweetCell.h
//  PresenSwitter
//
//  Created by hirauchi.shinichi on 2016/05/28.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TweetCell : NSTableCellView
@property (weak) IBOutlet NSImageView *imageIcon;
@property (weak) IBOutlet NSTextField *labelName;
@property (weak) IBOutlet NSTextField *labelBody;
@end
