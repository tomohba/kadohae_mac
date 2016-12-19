//
//  AppDelegate.m
//  角から生えるやつ
//
//  Created by Tomonori Ohba on 2016/07/03.
//  Copyright © 2016年 Tomonori Ohba. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSMenu *mainMenu;
@property (nonatomic, strong) NSStatusItem *statusItem;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self setupStatusItem];

    // マウスの座標をリアルタイムに取得する
    // 他のアプリケーションに対して送られたイベントを処理する
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSMouseMovedMask
                                           handler:^(NSEvent *event)
     {
         NSPoint point = [event locationInWindow];
         NSLog(@"global:(%lf, %lf)", point.x, point.y);
         
         // StatusMenuの場合、StatusMenuのWindowが取得できる（が、座標軸が違うので、ここでは無視する）
         if ([event window] == nil && point.x < 8 && point.y < 8) {
             [self.window startMainAnimation];
         }
     }];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)setupStatusItem
{
    NSStatusBar *systemStatusBar = [NSStatusBar systemStatusBar];
    self.statusItem = [systemStatusBar statusItemWithLength:NSVariableStatusItemLength];
    [self.statusItem setHighlightMode:YES];
    [self.statusItem setImage:[NSImage imageNamed:@"statusicon"]];
    [self.statusItem setMenu:self.mainMenu];
}

@end
