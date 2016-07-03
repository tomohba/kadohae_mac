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
    NSRect rect = CGRectMake(0, 0, 8, 8);
    NSTrackingArea *area = [[NSTrackingArea alloc]initWithRect:rect
                                                       options:NSTrackingMouseEnteredAndExited|NSTrackingActiveInActiveApp
                                                         owner:self
                                                      userInfo:nil];
    [self addTrackingArea:area];
}

- (void)drawRect:(NSRect)rect {
    [[NSColor clearColor] set];
    NSRectFill([self frame]);
    [self.image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    [self startMainAnimation];
}

- (void)startMainAnimation {
    if (self.animationTimer == nil || self.animationTimer.isValid == NO) {
        AppDelegate *appDelegate = (AppDelegate*) [NSApplication sharedApplication].delegate;
        [appDelegate.window setAlphaValue:1.0];
        
        self.animationFrame = 0;
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                               target:self
                                                             selector:@selector(mainAnimation:)
                                                             userInfo:nil
                                                              repeats:YES];
    }
}

-(void)mainAnimation:(NSTimer*)timer{
    NSString *imageNamed = [NSString stringWithFormat:@"%ld", (long)self.animationFrame];
    self.image = [NSImage imageNamed:imageNamed];
    [self setNeedsDisplay:YES];
    
    self.animationFrame++;
    if (self.animationFrame == 16) {
        [self.animationTimer invalidate];
        [self startEndAnimation];
    }
}

- (void)startEndAnimation {
    self.animationFrame = 0;
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                           target:self
                                                         selector:@selector(endAnimation:)
                                                         userInfo:nil
                                                          repeats:NO];
}

-(void)endAnimation:(NSTimer*)timer{
    NSString *imageNamed = [NSString stringWithFormat:@"%ld", (long)self.animationFrame];
    self.image = [NSImage imageNamed:imageNamed];
    [self setNeedsDisplay:YES];

    AppDelegate *appDelegate = (AppDelegate*) [NSApplication sharedApplication].delegate;
    [appDelegate.window setAlphaValue:0.0];
}


@end
