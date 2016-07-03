//
//  AppDelegate.h
//  角から生えるやつ
//
//  Created by Tomonori Ohba on 2016/07/03.
//  Copyright © 2016年 Tomonori Ohba. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CustomWindow.h"


@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet CustomWindow *window;

@end

