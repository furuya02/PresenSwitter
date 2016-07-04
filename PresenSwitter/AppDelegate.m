//
//  AppDelegate.m
//  PresenSwitter
//
//  Created by hirauchi.shinichi on 2016/05/27.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // ウインドウ最前面
    NSWindow *window = [[NSApp windows]objectAtIndex:0];
    [window setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces | NSWindowCollectionBehaviorFullScreenAuxiliary];
    [window setLevel: NSFloatingWindowLevel];

}

// プログラムがアクティブになった時
- (void)applicationWillBecomeActive:(NSNotification *)notification{
    NSLog(@"willBecomeActive");

    NSWindow *window = [[NSApp windows]objectAtIndex:0];
    [window setStyleMask:NSTitledWindowMask|NSResizableWindowMask|NSClosableWindowMask];// タイトル表示
    [window setBackgroundColor : [ NSColor lightGrayColor ]];
}

// プログラムが非アクティブになった時
- (void)applicationWillResignActive:(NSNotification *)notification{
    NSLog(@"willResignActive");

    NSWindow *window = [[NSApp windows]objectAtIndex:0];
    [window setStyleMask:NSBorderlessWindowMask];// タイトル非表示
    [window setBackgroundColor : [ NSColor clearColor ]];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
