#import <QuartzCore/QuartzCore.h>
#import "CustomView.h"
#import "AppDelegate.h"

@interface CustomView ()

@property (nonatomic, strong) NSImage *image;
@property (nonatomic, strong) NSTimer *animationTimer;
@property(nonatomic) NSInteger animationFrame;

@end

@implementation CustomView

- (void)awakeFromNib {
    self.image = [NSImage imageNamed:@"0"];
}

- (void)drawRect:(NSRect)rect {
    [[NSColor clearColor] set];
    NSRectFill([self frame]);
    [self.image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
}

- (void)startMainAnimation {
    if (self.animationTimer == nil || self.animationTimer.isValid == NO) {
        AppDelegate *appDelegate = (AppDelegate*) [NSApplication sharedApplication].delegate;

        
        // スクリーンサイズが変更されている可能性があるので、アニメーション開始時にウインドウ位置を修正
        [appDelegate.window setFrame:CGRectMake(0, 0, [appDelegate.window frame].size.width , [appDelegate.window frame].size.height) display:YES];

        // 表示開始
        [appDelegate.window setAlphaValue:1.0];
        
        self.animationFrame = 0;
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                               target:self
                                                             selector:@selector(mainAnimation:)
                                                             userInfo:nil
                                                              repeats:YES];
    }
}

-(void)mainAnimation:(NSTimer*)timer {
    NSString *imageNamed = [NSString stringWithFormat:@"%ld", (long)self.animationFrame];
    self.image = [NSImage imageNamed:imageNamed];
    [self setNeedsDisplay:YES];
    
    self.animationFrame++;
    if (self.animationFrame == 16) {
        [self.animationTimer invalidate];
        [self startMidAnimation];
    }
}

- (void)startMidAnimation {
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                           target:self
                                                         selector:@selector(midAnimation:)
                                                         userInfo:nil
                                                          repeats:NO];
    
}

- (void)midAnimation:(NSTimer*)timer {
    [self.animationTimer invalidate];
    [self startEndAnimation];
}


- (void)startEndAnimation {
    self.animationFrame = 5;
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.025
                                                           target:self
                                                         selector:@selector(endAnimation:)
                                                         userInfo:nil
                                                          repeats:YES];
}

- (void)endAnimation:(NSTimer*)timer {
    NSString *imageNamed = [NSString stringWithFormat:@"%ld", (long)self.animationFrame];
    self.image = [NSImage imageNamed:imageNamed];
    [self setNeedsDisplay:YES];

    AppDelegate *appDelegate = (AppDelegate*) [NSApplication sharedApplication].delegate;
    
    // 表示終了
    // 徐々にFadeout
    [appDelegate.window setAlphaValue:(self.animationFrame / 5.0)];
    
    self.animationFrame--;
    if (self.animationFrame == -1) {
        [self.animationTimer invalidate];
        self.animationFrame = 0;
    }
}

@end
